class Dispute
  include Mongoid::Document
  field :charge, :type => String
  field :amount, :type => Integer
  field :created, :type => Integer
  field :status, :type => String
  field :livemode, :type => Boolean
  field :currency, :type => String
  field :object, :type => String
  field :reason, :type => String
  field :balance_transaction, :type => String
  field :evidence_due_by, :type => Integer
  field :evidence, :type => String
end