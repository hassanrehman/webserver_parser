require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'tempfile'
require 'securerandom'

# Load project files..
Dir["./app/*.rb"].each { |f| require(f) }
Dir["./spec/*.rb"].each { |f| require(f) }
