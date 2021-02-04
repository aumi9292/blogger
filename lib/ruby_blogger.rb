require 'bundler/setup'
require 'yaml'

at_exit do 
  if $! 
    blogger = create_instance($!)
    logging(blogger)
  end
end

def create_instance(exception)
  blogger_entry = {}
  blogger_entry[:filename] = $0
  blogger_entry[:line_number] = $!.backtrace[0].split(':')[1]
  blogger_entry[:cause] = $!.backtrace[0].split('`')[-1]
  blogger_entry[:message] = $!.message
  blogger_entry[:type] = $!.class.to_s
  blogger_entry[:scope] = self.to_s
  blogger_entry[:time] = Time.now
  blogger_entry
end

def logging(structured)
  File.open('structured_exceptions.yml', 'a+') do |file|
    file.write (structured.to_yaml)
  end 
end