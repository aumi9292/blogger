# this may not be a safe one to test
# below is an exmaple from https://airbrake.io/blog/ruby-exception-handling/nomemoryerror

# probably, this should not be rescued and instead,
# allow the system to crash as it could lead to 
# hardware damage.

# more research to do.

begin
    limit = 2**31 - 1
    puts "Limit: #{limit}"
    puts "a" * limit
rescue NoMemoryError => e
    puts "#{e.class}: #{e.message}"
    puts e.backtrace.join("\n")
end