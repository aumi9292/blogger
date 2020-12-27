File.open("/etc/hosts") {|f| f << "example"}
  #=> IOError: not opened for writing

File.open("/etc/hosts") {|f| f.close; f.read }
  #=> IOError: closed stream