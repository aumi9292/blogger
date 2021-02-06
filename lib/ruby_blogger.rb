require 'bundler/setup'
require 'yaml'

at_exit do 
  if $! 
    blogger = create_instance($!)
    logging(blogger)
  end
end

def get_error_description(type)
  errors = {
    ZeroDivisionError: "Attempting to divide an Integer by 0.", 
    NoMethodError: "A method is called on a receiver that does not have that method defined."
  }

  return errors[type] if errors.key?(type)
  return 'Check out https://ruby-doc.org/core-2.7.0/Exception.html for more information.' if !errors.key?(type)
end

def create_instance(exception)
  blogger_entry = {}
  blogger_entry[:filename] = $0
  blogger_entry[:line_number] = $!.backtrace[0].split(':')[1]
  blogger_entry[:cause] = $!.backtrace[0].split('`')[-1]
  blogger_entry[:message] = $!.message
  blogger_entry[:type] = $!.class.to_s
  blogger_entry[:description] = get_error_description($!.class.to_s.to_sym)
  blogger_entry[:scope] = self.to_s
  blogger_entry[:time] = Time.now
  blogger_entry
end

def logging(structured)
  File.open('structured_exceptions.yml', 'a+') do |file|
    file.write (structured.to_yaml)
  end 
  puts 'Bug Logged Successfully:'
end
