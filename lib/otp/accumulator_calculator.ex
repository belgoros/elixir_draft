defmodule OTP.AccumulatorCalculator do
  def exec(:+, a, b), do: a + b
  def exec(:-, a, b), do: a - b
  def exec(:*, a, b), do: a * b
  def exec(:/, a, b), do: div(a, b)
end
