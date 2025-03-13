defmodule CodeBasics.NumberProcessor do
  def process(input) do
    with {number, _} <- Integer.parse(input),
         true <- is_even?(number),
         squared when squared < 100 <- number * number do
      {:ok, squared}
    else
      :error -> {:error, "Not a valid integer"}
      false -> {:error, "Number is not even"}
      large_square -> {:error, "Square too large: #{large_square}"}
    end
  end

  defp is_even?(number), do: rem(number, 2) == 0
end
