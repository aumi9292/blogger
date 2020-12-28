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

exceptions = read_all_exceptions
total = get_total_project_exceptions(exceptions)
counts = get_count_of_each_exception_class(exceptions)
display_total_and_counts(total, counts)