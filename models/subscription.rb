class Subscription
  include Mongoid::Document
  field :stripe_id, :type => String
  field :object, :type => String
  field :start, :type => Integer
  field :status, :type => String
  field :customer, :type => String
  field :current_period_start, :type => Integer
  field :current_period_end, :type => Integer
  field :ended_at, :type => Integer
  field :canceled_at, :type => Integer
  field :quantity, :type => Integer
  field :trial_start, :type => Integer
  field :trial_end, :type => Integer
  field :cancel_at_period_end, :type => Boolean
  field :application_fee_percent, :type => Float
  field :metadata, :type => Hash
  # field :plan, :type => BSON::Document
  # field :discount, :type => nil
  
  validates_uniqueness_of :stripe_id
end