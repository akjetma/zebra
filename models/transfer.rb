class Transfer
  include Mongoid::Document
  field :stripe_id, :type => String
  field :object, :type => String
  field :created, :type => Integer
  field :date, :type => Integer
  field :livemode, :type => Boolean
  field :amount, :type => Integer
  field :currency, :type => String
  field :status, :type => String
  field :type, :type => String
  field :balance_transaction, :type => String
  field :description, :type => String
  field :fee, :type => Integer
  field :other_transfers, :type => Array
  field :failure_message, :type => String
  field :failure_code, :type => String
  field :metadata, :type => Hash
  field :statement_description, :type => String
  field :recipient, :type => String
  field :fee_details, :type => Array
  field :statement_descriptor, :type => String
  # field :bank_account, :type => BSON::Document
  # field :account, :type => BSON::Document
  # field :summary, :type => BSON::Document
  # field :transactions, :type => BSON::Document
  
  validates_uniqueness_of :stripe_id
end