class Coupon
  include Mongoid::Document
  field :stripe_id, :type => String
  field :percent_off, :type => Integer
  field :object, :type => String
  field :livemode, :type => Boolean
  field :duration, :type => String
  field :times_redeemed, :type => Integer
  field :amount_off, :type => Integer
  field :currency, :type => String
  
  validates_uniqueness_of :stripe_id
end