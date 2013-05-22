require 'rubygems'

raise "This program requires Ruby 1.9" unless RUBY_VERSION =~ /1\.9/

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
