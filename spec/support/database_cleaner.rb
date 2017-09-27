# frozen_string_literal: true
# Check spec/support dir is auto-required in spec/rails_helper.rb.

# IMPORTANT! Delete the "config.use_transactional_fixtures = ..." line
# in spec/rails_helper.rb (we're going to configure it in this file you're
# reading instead).
require 'database_cleaner'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    rack_test = Capybara.current_driver == :rack_test

    DatabaseCleaner.strategy = rack_test ? :transaction : :truncation
    # Driver is probably for an external browser with an app
    # under test that does *not* share a database connection with the
    # specs, so use truncation strategy.
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
