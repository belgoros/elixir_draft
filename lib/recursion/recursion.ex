defmodule Recursion.Recursion do
  def sum(list) do
    do_sum(0, list)
  end

  defp do_sum(current_sum, []) do
    current_sum
  end

  defp do_sum(current_sum, [head | tail]) do
    do_sum(current_sum + head, tail)
  end

  # Show the difference when using tail recursion vs body recursion vs #reduce
  def addReduce(list) do
    Enum.reduce(list, 0, fn a, b -> a + b end)
  end

  def addTail(list) do
    addTail(0, list)
  end

  def addTail(acc, []) do
    acc
  end

  def addTail(acc, [head | tail]) do
    addTail(acc + head, tail)
  end

  def addBody([]) do
    0
  end

  def addBody([head | tail]) do
    addBody(tail) + head
  end
end

# Let's benchmark it with Benchee
# 	list = Enum.to_list(1..100_000_000)
#
# 	Benchee.run(
# 	  %{
# 	    "Tail" => fn -> Recursion.addTail(list) end,
# 	    "Body" => fn -> Recursion.addBody(list) end,
# 	    "Reduce" => fn -> Recursion.addReduce(list) end
# 	  },
# 	  time: 10,
# 	  memory_time: 2
# 	)
