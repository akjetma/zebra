class Customer
  include Mongoid::Document
  field :object, :type => String
  field :created, :type => Integer
  field :stripe_id, :type => String
  field :livemode, :type => Boolean
  field :description, :type => String
  field :email, :type => String
  field :account_balance, :type => Integer
  field :currency, :type => String
  field :default_card, :type => String
  field :delinquent, :type => Boolean
  field :metadata, :type => Hash
  # field :subscriptions, :type => BSON::Document
  # field :cards, :type => BSON::Document
  # field :next_recurring_charge, :type => BSON::Document
  # field :active_card, :type => BSON::Document
  # field :subscription, :type => BSON::Document
  # field :discount, :type => BSON::Document
  
  validates_uniqueness_of :stripe_id
end