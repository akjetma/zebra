class Plan
  include Mongoid::Document
  field :interval, :type => String
  field :object, :type => String
  field :livemode, :type => Boolean
  field :amount, :type => Integer
  field :name, :type => String
  field :stripe_id, :type => String
  field :interval_count, :type => Integer
  field :currency, :type => String

  validates_uniqueness_of :stripe_id
end