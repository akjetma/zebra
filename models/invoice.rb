class Invoice
  include Mongoid::Document
  field :date, :type => Integer
  field :stripe_id, :type => String
  field :period_start, :type => Integer
  field :period_end, :type => Integer
  field :subtotal, :type => Integer
  field :total, :type => Integer
  field :customer, :type => String
  field :object, :type => String
  field :attempted, :type => Boolean
  field :closed, :type => Boolean
  field :paid, :type => Boolean
  field :livemode, :type => Boolean
  field :attempt_count, :type => Integer
  field :amount_due, :type => Integer
  field :currency, :type => String
  field :starting_balance, :type => Integer
  field :ending_balance, :type => Integer
  field :next_payment_attempt, :type => Integer
  field :webhooks_delivered_at, :type => Integer
  field :charge, :type => String
  field :subscription, :type => String
  field :forgiven, :type => Boolean
  field :application_fee, :type => Integer
  field :metadata, :type => Hash
  field :statement_description, :type => String
  field :description, :type => String
  field :receipt_number, :type => String
  # field :lines, :type => BSON::Document
  # field :discount, :type => BSON::Document
  
  validates_uniqueness_of :stripe_id
end