def foo
  raise "Oups"
end


=begin
The most standard error types are subclasses 
of StandardError. A rescue clause without 
an explicit Exception class will rescue all
StandardErrors (and only those).

This may not be the most useful one since all 
descendants are what can provide context.
=end
