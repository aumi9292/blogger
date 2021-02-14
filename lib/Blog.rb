require 'bundler/setup'
require 'yaml'
require_relative 'BloggerException.rb'

class Blog
  attr_reader :exceptions, 
                :count_of_exceptions_in_folder,
                :unique_files, :count_and_files,
                :unique_exception_types, :specified_file

  FILE = 'structured_exceptions.yml'
  NO_EXCEPTIONS = "No exceptions have been raised by files that require 'ruby_blogger'"

  def initialize(specified_file = nil)
    @exceptions = YAML.load_stream(File.read(FILE))
    @unique_files = exceptions.map { |exc| exc.file }.uniq
    @count_and_files = "#{exceptions.length} in #{unique_files.join(' ')}"
    @unique_exception_types = exceptions.map { |exc| exc.type }.uniq
    @specified_file = specified_file
  end

  def count(type) 
    exceptions.select { |exc| exc.type == type }.length
  end 

  def header
    system('clear')
    puts "Total Exceptions: #{count_and_files}"
  end

  def folder_exceptions
    unique_exception_types.each do |type|
      puts  "\n"
      puts "Exception Class: #{type}"
      puts "Total: #{self.count(type)}"
      puts "-" * 15
    end
  end

  def display_summary
    self.header
    self.folder_exceptions
  end

  def read_exceptions_for_file(filename)
    exceptions.select { |exc| exc.file == filename }
  end 

  def display_exceptions_for_file(filename)
    file_exceptions = read_exceptions_for_file(filename)
    file_exceptions.each do |exc| 
      display_file_header(filename)
      exc.display
    end
    display_file_trailer
  end 

  def display_file_header(filename)
    puts "\n"
    puts "File: #{filename}"
    puts '-' * 15
  end 

  def display_file_trailer
    puts '-' * 15
  end

  def display_file_does_not_exist(file)
    puts "Sorry, #{file} is not a file in this folder."
  end 

  def display_blog
    if legit_file?(specified_file)
      self.display_exceptions_for_file(specified_file) 
    elsif illegit_file?(specified_file)
      self.display_file_does_not_exist(specified_file)
    else 
      self.display_summary
    end
  end

  def legit_file?(file)
    file && File.exist?(file)
  end 

  def illegit_file?(file)
    file && !File.exist?(file)
  end

  def self.exceptions?
    unless File.exist?(FILE)
      puts NO_EXCEPTIONS 
    else return true
    end
  end

  def self.generate_and_display_blog
    blog = self.new(ARGV[0])
    blog.display_blog
  end 
end