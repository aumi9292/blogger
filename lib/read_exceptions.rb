require 'bundler/setup'
require 'yaml'
require_relative 'BloggerException.rb'
require_relative 'Blog.rb'

Blog.generate_and_display_blog if Blog.exceptions?


