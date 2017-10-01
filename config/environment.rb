# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'localhost' }
end
# Initialize the Rails application.
Rails.application.initialize!
