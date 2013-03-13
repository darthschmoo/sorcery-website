# Load the rails application
require File.expand_path('../application', __FILE__)

unless Rails.env.production?  # avoids having to set debugger flag manually.
  require 'debugger'
  Debugger.start 
end

# Initialize the rails application
Sorcery::Application.initialize! do |config|
  puts "GOT HERE!!!!!!!!!!!!!!!!!!! inside sorc::app.init block"
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = Sorcery.config.smtp
end
