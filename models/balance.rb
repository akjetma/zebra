class Balance
  include Mongoid::Document
  field :pending, :type => Array
  field :available, :type => Array
  field :livemode, :type => Boolean
  field :object, :type => String
end