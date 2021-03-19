source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# gem 'devise'
gem 'devise', github: 'heartcombo/devise', branch: 'ca-omniauth-2'

gem 'carrierwave'

gem 'mini_magick'

gem 'acts_as_votable'

gem 'kaminari'

gem 'pry-nav'
gem 'pry-rails'
gem 'pry-remote'

gem 'bullet'

gem 'rails_best_practices'

gem 'benchmark'

gem 'cancancan'

# Figaro used for Simple Rails app configuration set and hide ENV attributes
gem 'figaro'

gem 'redis'

gem 'sidekiq'

# For delayed job
gem 'delayed_job_active_record'

gem 'delayed_job'

gem 'delayed_job_web'

gem 'jwt'

gem 'factory_bot_rails'

# Use Omniauth Facebook plugin
gem 'omniauth-facebook'

gem 'omniauth-google-oauth2'

# Use ActiveRecord Sessions to store more than 4kb session info
gem 'activerecord-session_store', '~> 1.0'

gem 'omniauth-rails_csrf_protection'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rspec-rails', '>= 3.9.0'
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem "webmock"

end

gem 'simplecov', require: false, group: :test

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
