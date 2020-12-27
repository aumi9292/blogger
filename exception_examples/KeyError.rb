h = {"foo" => :bar}
h.fetch("foo") #=> :bar
h.fetch("baz") #=> KeyError: key not found: "baz"