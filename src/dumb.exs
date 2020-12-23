defmodule DumbNumbers do
  def is_even?(number) do
    rem(number, 2) == 0
  end

  def is_odd?(number) do
    not is_even?(number)
  end
end

IO.inspect(DumbNumbers.is_even?(2))
IO.inspect(DumbNumbers.is_even?(3))

IO.inspect(DumbNumbers.is_odd?(2))
IO.inspect(DumbNumbers.is_odd?(3))
