require 'rubygems'
require 'bundler/setup'
require 'csv'
require 'tempfile'

# Load project files..
Dir["./app/*.rb"].each { |f| require(f) }
Dir["./spec/*.rb"].each { |f| require(f) }
