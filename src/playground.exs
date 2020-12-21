double = fn(x) -> x * 2 end
IO.inspect(double.(3))

twice = fn(fun) -> fn(x) -> fun.(fun.(x)) end end
IO.inspect(twice.(double).(3))
