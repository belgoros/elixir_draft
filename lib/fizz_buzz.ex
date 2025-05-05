defmodule FizzBuzz do
  # any number divisible by three with the word "fizz"
  # any number divisible by five with the word "buzz"
  # any number divisible by both three and five with the word "fizzbuzz"
  def run(number) do
    1..number
    |> Enum.to_list()
    |> Enum.map(fn x ->
      cond do
        is_fizz?(x) -> "Fizz"
        is_buzz?(x) -> "Buzz"
        is_fizz_and_buzz?(x) -> "FizzBuzz"
        true -> Integer.to_string(x)
      end
    end)
  end

  defp is_fizz?(number) do
    Integer.mod(number, 3) == 0
  end

  defp is_buzz?(number) do
    Integer.mod(number, 5) == 0
  end

  defp is_fizz_and_buzz?(number) do
    is_fizz?(number) && is_buzz?(number)
  end
end
