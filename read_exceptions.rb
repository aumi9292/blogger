require 'yaml'

exceptions = []

File.open('structured_exceptions.yml') do |yaml_file|
  YAML.load_stream(yaml_file) do |yaml_doc|
    exceptions << yaml_doc 
  end
end 

puts exceptions