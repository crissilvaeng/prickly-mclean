{:ok, today} = Date.new(2020, 12, 22)
IO.inspect(Date.day_of_week(today, :sunday))
# 3

{:ok, first} = Date.new(0, 1, 1)
IO.inspect(Date.day_of_week(first))

days_off = Date.range(~D[2020-12-24], ~D[2021-01-03])
IO.inspect(Enum.count(days_off))
# 11

IO.inspect(~D[2020-12-25] in days_off)
IO.inspect(~D[2021-01-01] in days_off)
# true
# true

IO.inspect("batatinha")
