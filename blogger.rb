# Elements for execution
execution_lang = 'ruby '
file = ARGV[0]        
logging_method = ' 2>'
log_file = 'error_log.rb'  
parser = 'exception_parser.rb '

silent_logging = execution_lang + file + logging_method + log_file

parse_and_save_to_yaml = execution_lang + parser + log_file

# Execute file with Bash
`#{execution_lang} #{file}` 

# Silent logging via Ruby
system(silent_logging)

#executing the exception_parse file, passing the log_file in as an argument 

system(parse_and_save_to_yaml)