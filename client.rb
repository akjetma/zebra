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
  end

  class Harvester
    include Sidekiq::Worker
    sidekiq_options :queue => :zebra

    class << self
      attr_reader :stripe_class
    end

    def perform(opts={})
      Zebra::Util.convert_to_zebra_object(self.class.stripe_class.all)
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
      when *(Stripe::Util.object_classes.values << Stripe::StripeObject)
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