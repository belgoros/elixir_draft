defmodule Recursion.Tripler do
  @moduledoc false

  def triple([head | tail]) do
    [3 * head | triple(tail)]
  end

  def triple([]) do
    IO.puts("Done")
  end
end

IO.inspect(Recursion.Tripler.triple([1, 2, 3, 4, 5]))
