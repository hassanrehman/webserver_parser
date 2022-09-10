#!/usr/bin/env ruby

load('boot.rb')

# To support ./parser.rb sytax on command line
if $PROGRAM_NAME == __FILE__
  Parser.new(ARGV).run
end
