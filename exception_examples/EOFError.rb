file = File.open("/etc/hosts")
file.read
file.gets     #=> nil
file.readline #=> EOFError: end of file reached