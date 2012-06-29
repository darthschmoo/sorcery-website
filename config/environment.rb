# Load the rails application
require File.expand_path('../application', __FILE__)


unless Rails.env.production?  # avoids having to set debugger flag manually.
  require 'debugger'
  Debugger.start 
end

# Initialize the rails application
Sorcery::Application.initialize!

