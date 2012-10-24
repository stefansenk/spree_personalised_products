require 'rubygems'
require 'spork'


Spork.prefork do

  # Configure Rails Environment
  ENV['RAILS_ENV'] = 'test'

  require File.expand_path('../dummy/config/environment.rb',  __FILE__)

  require 'rspec/rails'
  require 'ffaker'
  require 'database_cleaner'

  require 'spree/core/testing_support/factories'
  require 'spree/core/testing_support/controller_requests'
  require 'spree/core/url_helpers'


  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods

    # Allows access to Spree's routes in specs:
    config.include Spree::Core::UrlHelpers
    config.include Spree::Core::TestingSupport::ControllerRequests, :type => :controller

    config.mock_with :rspec

    config.use_transactional_fixtures = false

    config.before(:each) do
      if example.metadata[:js]
        DatabaseCleaner.strategy = :truncation, { :except => ['spree_countries', 'spree_zones', 'spree_zone_members', 'spree_states', 'spree_roles'] }
      else
        DatabaseCleaner.strategy = :transaction
      end
    end

    config.before(:each) do
      DatabaseCleaner.start
      # reset_spree_preferences
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end

end

Spork.each_run do

  # TODO
  # FactoryGirl.reload
  
  # Dir[File.expand_path("../../lib/**/*.rb",  __FILE__)].each {|f| load f }
  Dir[File.expand_path("../../spec/support/**/*.rb",  __FILE__)].each {|f| load f }
  Dir[File.expand_path("../../app/**/*.rb",  __FILE__)].each {|f| load f }

end
