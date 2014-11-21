class InvoiceItem
  include Mongoid::Document
  field :object, :type => String
  field :stripe_id, :type => String
  field :date, :type => Integer
  field :amount, :type => Integer
  field :livemode, :type => Boolean
  field :proration, :type => Boolean
  field :currency, :type => String
  field :customer, :type => String
  field :description, :type => String
  field :invoice, :type => String
  field :subscription, :type => String
  field :metadata, :type => Hash

  validates_uniqueness_of :stripe_id
end