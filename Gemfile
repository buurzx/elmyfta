# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'

gem 'reform'
gem 'reform-rails'
gem 'dry-validation'

gem 'slim-rails'
gem 'simple_form'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'devise'

gem 'storext'

gem 'will_paginate'

gem 'exception_notification'
gem 'rubyXL'

gem 'babosa'
gem 'friendly_id'

gem 'sitemap_generator'
gem 'whenever', require: false


group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'coveralls', require: false
  gem 'factory_girl_rails'
  gem 'mina'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'letter_opener_web'
  gem 'rubocop'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'ffaker'
  gem 'rack_session_access'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'#, platforms: %i[mingw mswin x64_mingw jruby]
