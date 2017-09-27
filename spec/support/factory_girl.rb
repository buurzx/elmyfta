# frozen_string_literal: true

module FactoryGirl
  mattr_accessor :used_factories

  self.used_factories = []

  def self.factory_by_name(name)
    used_factories << name

    factories.find(name)
  end

  def self.unused_factories
    factories.map(&:name) - used_factories
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.after(:suite) do
    if FactoryGirl.unused_factories.present? && ENV['TEST_ENV_NUMBER'].nil?
      puts "\nWARNING: You have #{FactoryGirl.unused_factories.count} unused factories: #{FactoryGirl.unused_factories}"
    end
  end
end

# Suggested docs
# --------------
# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
