double = fn x -> x * 2 end
IO.inspect(double.(3))

twice = fn fun -> fn x -> fun.(fun.(x)) end end
IO.inspect(twice.(double).(3))

map = Map.new()
map = Map.put(map, :a, "value for a")
map = Map.put(map, :b, "value for b")

IO.inspect(map)
