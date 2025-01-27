defmodule Recursion.FibonacciRecursion do
  def advance({nil, 0}), do: {0, 1}
  def advance({prev, cur}), do: {cur, prev + cur}

  def at(seq \\ {nil, 0}, n)
  def at(seq, 0), do: elem(seq, 1)

  def at(seq, n) do
    seq
    |> advance()
    |> at(n - 1)
  end

  def take(seq \\ {nil, 0}, n, acc \\ [])
  def take(_seq, 0, acc), do: Enum.reverse(acc)

  def take(seq, n, acc) do
    take(advance(seq), n - 1, [elem(seq, 1) | acc])
  end
end

Recursion.FibonacciRecursion.take(10) |> IO.inspect()
Recursion.FibonacciRecursion.at(9) |> IO.inspect()
