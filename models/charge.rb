class Charge
  include Mongoid::Document
  field :stripe_id, :type => String
  field :object, :type => String
  field :created, :type => Integer
  field :livemode, :type => Boolean
  field :paid, :type => Boolean
  field :amount, :type => Integer
  field :currency, :type => String
  field :refunded, :type => Boolean
  field :captured, :type => Boolean
  field :balance_transaction, :type => String
  field :failure_code, :type => String
  field :customer, :type => String
  field :invoice, :type => String
  field :fee, :type => Integer
  field :fee_details, :type => Array
  field :failure_message, :type => String
  field :description, :type => String
  field :amount_refunded, :type => Integer
  field :metadata, :type => Hash
  field :receipt_email, :type => String
  field :receipt_number, :type => String
  field :statement_description, :type => String
  field :disputed, :type => Boolean
  field :shipping, :type => Hash
  # field :dispute, :type => nil
  # field :card, :type => BSON::Document

  validates_uniqueness_of :stripe_id
end