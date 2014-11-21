class Account
  include Mongoid::Document
  field :stripe_id, :type => String
  field :email, :type => String
  field :statement_descriptor, :type => String
  field :display_name, :type => String
  field :timezone, :type => String
  field :details_submitted, :type => Boolean
  field :charge_enabled, :type => Boolean
  field :transfer_enabled, :type => Boolean
  field :currencies_supported, :type => Array
  field :default_currency, :type => String
  field :country, :type => String
  field :object, :type => String

  validates_uniqueness_of :stripe_id
end