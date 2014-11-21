class Card
  include Mongoid::Document
  field :stripe_id, :type => String
  field :object, :type => String
  field :last4, :type => String
  field :brand, :type => String
  field :funding, :type => String
  field :exp_month, :type => Integer
  field :exp_year, :type => Integer
  field :fingerprint, :type => String
  field :country, :type => String
  field :cvc_check, :type => String
  field :customer, :type => String
  field :type, :type => String
  field :address_city, :type => String

  validates_uniqueness_of :stripe_id
end