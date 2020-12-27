
require 'yaml'

exception = ''


File.readlines(ARGV[0]).each do |line|
  exception << line
end 

def parse_filename(exception)
  file_delim = ':'
  end_name = exception.index(':')
  exception[0...end_name]
end 

def parse_line_number(exception)
  line_pos = parse_filename(exception).length + 1
  exception[line_pos]
end 

def parse_cause_in_line(exception)
  cause_start = exception.index('`') + 1
  cause_end = exception.index('\'')
  exception[cause_start...cause_end]
end 

def parse_exception_message(exception)
  msg_start = (exception =~ /':\s/) + 3
  msg_end = exception =~ /\s\(/
  exception[msg_start...msg_end]
end 

def parse_exception_class(exception)
  class_with_parens = exception.slice /\(\w+\)/
  class_with_parens[1...-1]
end 

def parse_scope(exception)
  scope_start = exception.rindex('<') + 1
  scope_end = exception.rindex('>')
  exception[scope_start...scope_end]
end 



#building a hash with parsed components
def build_exception_hash(exception)
  exc = {}
  exc[:filename] = parse_filename(exception)
  exc[:line_number] = parse_line_number(exception)
  exc[:cause] = parse_cause_in_line(exception)
  exc[:message] = parse_exception_message(exception)
  exc[:type] = parse_exception_class(exception)
  exc[:scope] = parse_scope(exception)
  exc[:time] = Time.now
  exc 
end 

structured = build_exception_hash(exception)

File.open('structured_exceptions.yml', 'a+') do |file|
  file.write(structured.to_yaml)
end 