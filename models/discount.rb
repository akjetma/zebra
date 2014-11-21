class Discount
  include Mongoid::Document
  field :start, :type => Integer
  field :object, :type => String
  field :customer, :type => String
  field :stripe_id, :type => String
  field :end, :type => Integer
  # field :coupon, :type => BSON::Document

  validates_uniqueness_of :stripe_id
end