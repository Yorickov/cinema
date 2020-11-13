# require 'rubygems'
# require 'bundler/setup'

require_relative 'lib/Half'

puts Half.new.call(ARGV[ARGV.size - 1].to_i)
