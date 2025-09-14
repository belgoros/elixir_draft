defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when is_integer(count) and count >= 1 do
    # fast path
    if count == 1, do: 2, else: find_primes([2], 3, 1, count)
  end

  # primes: list of discovered primes in ascending order
  # candidate: integer to test next
  # count: how many primes we already have
  # target: desired n
  defp find_primes(primes, candidate, count, target) when count < target do
    # skip even numbers (except 2 which we already have)
    candidate =
      if candidate > 2 and rem(candidate, 2) == 0, do: candidate + 1, else: candidate

    if prime?(candidate, primes) do
      # append new prime
      primes = primes ++ [candidate]

      if count + 1 == target,
        do: candidate,
        else: find_primes(primes, candidate + 2, count + 1, target)
    else
      find_primes(primes, candidate + 2, count, target)
    end
  end

  # check primality by dividing only by known primes <= sqrt(candidate)
  defp prime?(candidate, primes) do
    limit = :math.sqrt(candidate) |> trunc()

    primes
    |> Enum.take_while(fn p -> p <= limit end)
    |> Enum.all?(fn p -> rem(candidate, p) != 0 end)
  end
end
