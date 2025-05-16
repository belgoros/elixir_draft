defmodule FizzBuzz do
  # any number divisible by three with the word "fizz"
  # any number divisible by five with the word "buzz"
  # any number divisible by both three and five with the word "fizzbuzz"
  def run(number) do
    1..number
    |> Enum.to_list()
    |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(number) when rem(number, 15) == 0, do: "FizzBuzz"
  defp fizzbuzz(number) when rem(number, 5) == 0, do: "Buzz"
  defp fizzbuzz(number) when rem(number, 3) == 0, do: "Fizz"
  defp fizzbuzz(number), do: Integer.to_string(number)
end
