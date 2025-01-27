defmodule Fibonacci do
  def stream(seq \\ {nil, 0}) do
    seq
    |> Stream.iterate(fn
      {nil, 0} -> {0, 1}
      {prev, cur} -> {cur, prev + cur}
    end)
    |> Stream.map(fn {_prev, cur} -> cur end)
  end
end

# the two original examples
Fibonacci.stream()
|> Enum.take(10)
|> IO.inspect()

Fibonacci.stream()
|> Enum.at(9)
|> IO.inspect()

# the considered expansions
Fibonacci.stream()
|> Stream.drop(10)
|> Enum.take(10)
|> IO.inspect()

Fibonacci.stream()
|> Enum.find(fn n -> n > 100 end)
|> IO.inspect()
