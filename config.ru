# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Sorcery::Application


# If the db doesn't exist, I want the rails app to nonetheless boot, and take the installer to a page where they can enter their DB information and have it create/populate.
