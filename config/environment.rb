# Load the rails application
require File.expand_path('../application', __FILE__)

require 'ruby-debug'
Debugger.start unless Rails.env.production?  # avoids having to set debugger flag manually.

# Initialize the rails application
Sorcery::Application.initialize!

