source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development,:test do
  gem 'sqlite3'
end
group :production do
#  gem 'pg'
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
group :development,:test do
  gem "rspec"
  gem "rspec-rails"
  gem "capybara"
  gem "spork"
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
