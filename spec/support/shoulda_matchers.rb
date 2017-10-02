# frozen_string_literal: true

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Suggested docs
# --------------
# https://gist.github.com/kyletcarlson/6234923
# https://github.com/thoughtbot/shoulda-matchers#rspec
# https://github.com/thoughtbot/shoulda-matchers#configuration
# https://github.com/thoughtbot/shoulda-matchers#activemodel-matchers
# http://thoughtbot.github.io/shoulda-matchers/
# http://thoughtbot.github.io/shoulda-matchers/docs/v3.0.0.rc1/
# http://thoughtbot.github.io/shoulda-matchers/docs/v3.0.0.rc1/Shoulda/Matchers/ActiveModel.html
# http://thoughtbot.github.io/shoulda-matchers/docs/v3.0.0.rc1/Shoulda/Matchers/ActiveRecord.html
