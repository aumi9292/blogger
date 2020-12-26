# this one will not be raised, 
# see https://airbrake.io/blog/ruby-exception-handling/scripterror

def print_exception(exception, explicit)
    puts "[#{explicit ? 'EXPLICIT' : 'INEXPLICIT'}] #{exception.class}: #{exception.message}"
    puts exception.backtrace.join("\n")
end

begin
    eval("1+2=3")
rescue => e
    print_exception(e, false)
end