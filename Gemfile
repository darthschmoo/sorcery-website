source 'http://rubygems.org'

gem "fun_with_files"
gem "fun_with_configurations"

gem 'rails', '= 3.2.13'
gem 'webrick', '~> 1.3.1'
 
group :assets do
  gem 'compass', git: 'git://github.com/chriseppstein/compass', branch: 'master'
  gem 'compass-rails'
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'uglifier',     '>= 1.0'
end

group :development do
  # Deploy with Capistrano
  gem 'capistrano', '~> 3.0', require: false, group: :development
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'

  # To use debugger
  gem 'debugger'
end



group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  # gem 'minitest'
  gem 'factory_girl', "~> 3.0"
  gem 'factory_girl_rails', "~> 3.0"
  gem 'faker'

  # To use debugger
  gem 'debugger'
end

group :beta do
  gem 'debugger'
end

group :production do
  gem 'mysql2'
end

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


gem 'jquery-rails'   ##, '~> 3.1.3'



# Do you remember why therubyracer was initially tagged as needing version  ~> 0.9.9 ? 
# Do you remember why we asked for it in the first place?
# Memory is fleeting, and the purposes of our past selves hold no meaning to us.
# Goodbye, therubyracer.  My memory has failed you.
# gem 'therubyracer', '~> 0.9.9'

gem 'authlogic', '>= 3.1'

 
gem 'will_paginate', '~> 3.0'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'


gem 'rubyzip'

# File uploader
gem 'carrierwave'

gem 'bundler'
gem 'bluecloth'
gem 'liquid'
gem 'haml'
# gem 'eeepub'
# gem 'epubforge', "~> 0.0", ">= 0.0.11"
gem 'pacecar'

# required for publicity tweets
# gem 'twitter'
# gem 'oauth'


# misc
gem 'rubytree'