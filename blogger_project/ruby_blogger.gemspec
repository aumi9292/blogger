Gem::Specification.new do |s|
  s.name        = 'ruby_blogger'
  s.version     = '1.0.0'
  s.summary     = 'Capture and display data about exceptions your .rb file raises'
  s.description = 'A command line developer tool to track exceptions'
  s.authors     = ['Leena Lallmon', 'Austin Miller']
  s.email       = 'austin.miller@colorado.edu'
  s.homepage    = 'https://github.com/aumi9292/blogger'
  s.files       = ['./lib/ruby_blogger.rb', './lib/read_exceptions.rb']
  s.executables << 'blog'
end