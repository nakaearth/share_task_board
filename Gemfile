source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development,:test do
  gem 'bullet' 
	gem 'sqlite3'
	# Chrome Rails Panel
	gem 'meta_request', '0.2.1'
end
group :production do
  gem "mysql2"
  gem 'unicorn'
  gem 'newrelic_rpm'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
end

# To use debugger
# gem 'debugger'

#omniauth
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

#Test
group :test do
  gem "rspec"
  gem "rspec-rails"
  gem "cucumber-rails", "~> 1.0", require: false
  gem 'database_cleaner'
  gem "capybara"
  gem "spork"
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber' 
  gem 'factory_girl_rails'
end

#paginate
gem "will_paginate"

#Pusher
gem "pusher"

#jpmobile
gem 'jpmobile'

#cloudinary
gem 'carrierwave'
gem 'cloudinary'

#Ajax Libs
gem 'turbolinks'

#Elastic search
gem 'tire', '~>0.4.1'

#DELAY JOB
#gem 'delayed_job'
#gem 'delayed_job_active_record'
#gem "daemons"
#sidekiq
gem 'sidekiq'


#strong parameter
gem 'strong_parameters'

#pry-rails
gem 'pry-rails'

#clockwork
gem 'clockwork'
gem 'heroku'

#Error Page
group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

gem "asset_sync"

#PDF
gem "prawn" ,">= 0.8.4"

#setting
gem 'settingslogic'

#trackman
gem 'trackman'

#jemalloc
#gem 'jemalloc'

