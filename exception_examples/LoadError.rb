
# source: https://airbrake.io/blog/ruby-exception-handling/loaderror

def print_exception(exception)
    puts exception.class
    puts exception.message
    puts exception.backtrace.join("\n")
    p self
end

begin
    load 'invalid/file/path'
rescue Exception => e
    print_exception(e)
end