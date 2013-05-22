# Load the rails application
require File.expand_path('../application', __FILE__)

unless Rails.env.production?  # avoids having to set debugger flag manually.
  require 'debugger'
  Debugger.start 
end

# Initialize the rails application
Sorcery::Application.initialize!

Sorcery::Application.config.action_mailer.delivery_method = :smtp
Sorcery::Application.config.action_mailer.smtp_settings = Sorcery.config.smtp.to_hash
