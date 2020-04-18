# Requires factories and other useful helpers defined in spree_core.
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/testing_support/factories'
require 'spree/testing_support/preferences'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/flash'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/order_walkthrough'
require 'spree/testing_support/auth_helpers'
require 'spree/testing_support/checkout_helpers'
require 'spree/testing_support/caching'

# API v2 helpers
require 'spree/api/testing_support/v2/base'
require 'spree/api/testing_support/v2/current_order'

RSpec.configure do |config|
  # Infer an example group's spec type from the file location.
  config.infer_spec_type_from_file_location!

  # == URL Helpers
  #
  # Allows access to Spree's routes in specs:
  #
  # visit spree.admin_path
  # current_path.should eql(spree.products_path)
  config.include Spree::TestingSupport::UrlHelpers

  # == Requests support
  #
  # Adds convenient methods to request Spree's controllers
  # spree_get :index
  config.include Spree::TestingSupport::ControllerRequests, type: :controller

  config.include Spree::TestingSupport::Preferences
  config.include Spree::TestingSupport::Flash

  config.include Spree::TestingSupport::AuthHelpers, type: :feature
  config.include Spree::TestingSupport::CheckoutHelpers, type: :feature

  config.before :each do
    Rails.cache.clear
    reset_spree_preferences do |config|
      # config.my_custom_preference = 10
    end
    create(:store)
  end
end