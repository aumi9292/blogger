require 'bundler/setup'
require 'yaml'
require_relative 'BloggerException.rb'

at_exit do 
  BloggerException.new.log if $!
end


