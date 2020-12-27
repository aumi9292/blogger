fiber = Fiber.new{}
fiber.resume #=> nil
fiber.resume #=> FiberError: dead fiber called