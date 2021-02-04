require 'bundler/setup'
require 'yaml'
#opens the .yml file, which is an IO object, passes it to YAML.load_streams. In the block, yaml_doc represents each exception in the .yml file
def read_all_exceptions
  exceptions = []
  File.open('structured_exceptions.yml') do |yaml_file|
    YAML.load_stream(yaml_file) do |yaml_doc|
      exceptions << yaml_doc 
    end
  end 
  exceptions
end 

#The following grouping of methods parse and display exception data for the whole project folder

def get_total_project_exceptions(exceptions)
  exceptions.length
end

def get_count_of_each_exception_class(exceptions)
  counts = {}
  exceptions.each do |exception|
    type = exception[:type]
    counts[type] ? counts[type] += 1 : counts[type] = 1
  end 
  counts
end 

#display count of total exceptions and each exception class and its count
def display_total_and_counts(total, counts)
  system('clear')
  puts "Total Exceptions: #{total}"
  counts.each do |type, count|
    puts  "\n"
    puts "Exception Class: #{type}"
    puts "Total: #{count}"
    puts "-" * 80
  end
end

#combines all get methods to display all exceptions and counts raised by all files in the project folder
def display_summary
  exceptions = read_all_exceptions
  total = get_total_project_exceptions(exceptions)
  counts = get_count_of_each_exception_class(exceptions)
  display_total_and_counts(total, counts)
end 

#These methods parse and display exception data for specified files

#get all exceptions for a given filename
def read_exceptions_for_file(filename)
  exceptions = read_all_exceptions
  exceptions.select do |exc|
    exc[:filename] == filename
  end 
end 

#display all exceptions and data for a given filename
def display_exceptions_for_file(filename)
  display_header_info(filename)
  display_each_exception(filename)
  display_trailer
end 

#passes each exception to format_exception_line and outputs each line
def display_each_exception(filename)
exceptions = read_exceptions_for_file(filename)
  lines = exceptions.map do |exc|
    format_exception_line(exc[:type], 
                          exc[:line_number],
                          exc[:time])
  end 
  puts lines
end 

#provide simple formatting for each exception class and line number
def format_exception_line(type, line, time)
  date, time, tz = separate_date_and_time(time)
  l_hash = { class: type, Line: line, Time: time, Date: date }
  l_hash.map { |pair| pair.join(': ') }.join('   ')
end 

#separates date, time, and tz
def separate_date_and_time(time)
  time.to_s.split(/\s/)
end 

#display simple header in CL
def display_header_info(filename)
  puts "\n"
  puts "File: #{filename}"
  puts '-' * 80
end 

#display simple trailer in CL
def display_trailer
  puts '-' * 80
end

#displays error message if user specifies non-existent file
def display_file_does_not_exist(file)
  puts "Sorry, #{file} is not a file in this folder."
end 

#functional logic to capture command line input and either display information for the file specified in the command line or display data for the entire folder if no file is specified.
specified_file = ARGV[0]

if specified_file && File.exist?(specified_file)
  display_exceptions_for_file(specified_file) 
elsif specified_file && !File.exist?(specified_file)
  display_file_does_not_exist(specified_file)
else 
  display_summary
end 