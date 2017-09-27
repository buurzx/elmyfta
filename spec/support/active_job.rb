# frozen_string_literal: true
RSpec.configure do |config|
  config.include ActiveJob::TestHelper

  config.before(:each) do
    clear_enqueued_jobs
  end
end

ActiveJob::Base.queue_adapter = :test

# Suggested docs
# --------------
# http://api.rubyonrails.org/classes/ActiveJob/TestHelper.html
# https://medium.com/@chuckjhardy/testing-rails-activejob-with-rspec-5c3de1a64b66
