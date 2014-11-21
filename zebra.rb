require 'pry'
require 'rest-client'
require 'mongoid'

STRIPE_KEY = ENV['STRIPE_API_KEY']
STRIPE_VERSION = '2014-10-07'
STRIPE_RESOURCE = RestClient::Resource.new('https://api.stripe.com/v1', user: STRIPE_KEY, headers: {'Stripe-Version' => STRIPE_VERSION})

Mongoid.load!("mongoid.yml")

require_relative 'models/account'
require_relative 'models/balance'
require_relative 'models/card'
require_relative 'models/charge'
require_relative 'models/coupon'
require_relative 'models/customer'
require_relative 'models/discount'
require_relative 'models/dispute'
require_relative 'models/event'
require_relative 'models/invoice'
require_relative 'models/invoice_item'
require_relative 'models/plan'
require_relative 'models/subscription'
require_relative 'models/transfer'
require_relative 'managers/event'
require_relative 'util'

binding.pry