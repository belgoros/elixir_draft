defmodule FizzBuzz2 do
  def run(n) when is_integer(n) and n > 0 do
    fizzbuzz_loop(1, n)
  end

  defp fizzbuzz_loop(current, max) when current <= max do
    current
    |> fizzbuzz()
    |> IO.puts()

    fizzbuzz_loop(current + 1, max)
  end

  defp fizzbuzz_loop(current, max) when current > max, do: :ok

  defp fizzbuzz(number) when rem(number, 15) == 0, do: "FizzBuzz"
  defp fizzbuzz(number) when rem(number, 5) == 0, do: "Buzz"
  defp fizzbuzz(number) when rem(number, 3) == 0, do: "Fizz"
  defp fizzbuzz(number), do: Integer.to_string(number)
end
