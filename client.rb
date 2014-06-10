require 'pry'
require 'stripe'
require 'mongo_mapper'
require 'sidekiq'

MongoMapper.connection = Mongo::MongoClient.new
MongoMapper.database = 'zebra'

Stripe.api_key = ENV['STRIPE_API_KEY']
Stripe.api_version = '2014-05-19'

module Zebra
  class ZebraObject
    def self.make_or_retrieve(object)
      if object.id && response = self.first(:stripe_id => object.id)
        return response
      else
        response = self.new
        object.each do |key, val|
          next if val.nil?
          key = :stripe_id if key == :id
          self.set_key(key, val) if !self.column_names.include?(key.to_s)
          response.send(:"#{key}=", Zebra::Util.convert_to_zebra_object(val))
        end
        response.save!
        response
      end
    end

    def self.set_key(key_name, value)
      case value
      when Stripe::ListObject
        many key_name, :class_name => "Zebra::ZebraObject::#{value.first.class.class_name}"
      when *Stripe::Util.object_classes.values
        one key_name, :class_name => "Zebra::ZebraObject::#{value.class.class_name}"
      when TrueClass, FalseClass
        key key_name, Boolean
      else
        key key_name, value.class
      end
    end
  end

  class Harvester
    include Sidekiq::Worker
    sidekiq_options :queue => :zebra

    class << self
      attr_reader :stripe_class
    end

    def perform(opts={})
      Zebra::Util.convert_to_zebra_object(self.class.stripe_class.all(opts))
    end
  end

  module Util
    def self.convert_to_zebra_object(object)
      case object
      when Hash
        object.inject({}) { |r, o| r[o[0]] = convert_to_zebra_object(o[1]); r }
      when Array
        object.map { |o| convert_to_zebra_object(o) }
      when Stripe::ListObject
        convert_to_zebra_object(object.to_a)
      when *Stripe::Util.object_classes.values
        Zebra::ZebraObject.const_get(object.class.class_name).make_or_retrieve(object)
      when Stripe::StripeObject
        convert_to_zebra_object(object.to_hash)
      else
        object
      end
    end
  end
end

(Stripe::Util.object_classes.values - [Stripe::ListObject]).each do |stripe_class|
  klass = Class.new(Zebra::ZebraObject) { include MongoMapper::Document }
  Zebra::ZebraObject.const_set(stripe_class.class_name, klass)
end

(Stripe::Util.object_classes.values.select { |c| c.respond_to?(:all) }).each do |stripe_class|
  klass = Class.new(Zebra::Harvester) { @stripe_class = stripe_class }
  Zebra::Harvester.const_set(stripe_class.class_name, klass)
end

binding.pry