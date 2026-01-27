defmodule Streamx do
  # [9, -1, "foo", 25, 49]
  # =>
  # 1. sqrt(9) = 3.0
  # 2. sqrt(25) = 5.0
  # 3. sqrt(49) = 7.0
  def list_sqrt(entries) do
    entries
    |> Stream.filter(&(is_number(&1) && &1 > 0))
    |> Stream.map(&{&1, :math.sqrt(&1)})
    |> Stream.with_index()
    |> Enum.each(fn {{input, result}, index} ->
      IO.puts("#{index + 1}. sqrt(#{input}) = #{result}")
    end)
  end
end
