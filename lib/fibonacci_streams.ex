defmodule Fibonacci do
  def stream(seq \\ {nil, 0}) do
    seq
    |> Stream.iterate(fn
      {nil, 0} -> {0, 1}
      {prev, cur} -> {cur, prev + cur}
    end)
    |> Stream.map(fn {_prev, cur} -> cur end)
  end

	def stream_unfold(limit) do
		Stream.unfold({0,1}, fn {f1,f2} -> {f1, {f2, f1 + f2}} end) |> Enum.take(limit)
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

IO.puts("Result when calling Stream.unfold/2 for 10 numbers:")
Fibonacci.stream_unfold(10) |> IO.inspect
