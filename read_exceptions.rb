require 'yaml'

def read_all_exceptions
  exceptions = []
  File.open('structured_exceptions.yml') do |yaml_file|
    YAML.load_stream(yaml_file) do |yaml_doc|
      exceptions << yaml_doc 
    end
  end 
  exceptions
end 

def read_exceptions_for_file(filename)
  exceptions = read_all_exceptions
  exceptions.select do |exc|
    exc[:filename] == filename
  end 
end 

def display_exceptions_for_file(filename)
  puts "\n"
  puts "File: #{filename}"
  puts '-' * 80
  exceptions = read_exceptions_for_file(filename)
  exceptions.each do |exc|
    format_type_and_line(exc[:type], exc[:line_number])
  end 
  puts '-' * 80
end 

def format_type_and_line(type, line)
  type_length = type.length
  puts "Class: #{type}" + " " * (50 - type_length) + "Line: #{line}"
end 

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

def display_summary
  exceptions = read_all_exceptions
  total = get_total_project_exceptions(exceptions)
  counts = get_count_of_each_exception_class(exceptions)
  display_total_and_counts(total, counts)
end 

specified_file = ARGV[0]

if specified_file && File.exist?(specified_file)
  display_exceptions_for_file(specified_file) 
else 
  display_summary
end 