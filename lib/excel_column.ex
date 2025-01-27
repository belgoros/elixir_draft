defmodule ElixirDraft.ExcelColumn do
  def column_to_integer(column) do
    result =
      column
      |> String.upcase()
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.reduce(0, fn {char, index}, acc ->
        value = hd(String.to_charlist(char)) - ?A + 1
        (acc + value * :math.pow(26, index)) |> round()
      end)

    result - 1
  end

  # Given an Excel column name (A, B, C, D, … AA, AB, AC,… AAA…, etc.).
  # Return a corresponding integer value (A=0, B=1,… AA=26…), etc.
  # Example: Column AGH

  # A → acc = 0 → 0 * 26 + 1 → return 1
  # G → acc = 1 → 1 * 26 + 7 → return 33
  # H → acc = 33 → 33 * 26 + 8 → return 866
  # Result = 866 - 1 → 865

  # <<char, rest::binary>> = "A" creates these bindings: char = "A", rest = "" (try this in iex / command line)
  # <<char, rest::binary>> = "" does not match, but <<>> = "" matches (<<>> is an empty bitstring, you could substitute it with "")
  # ?A returns the codepoint of “A” which is 65 (docs), avoiding the “magic number” of 65
  # The solution above also handles empty strings, returning 0
  # Only column_to_int/1 is public, the recursive implementation is defined as private function.
  # The user does not need to care about the accumulator or its initial value

  def column_to_int(str), do: column_to_int(str, 0)

  defp column_to_int(<<>>, acc), do: acc - 1

  defp column_to_int(<<char, rest::binary>>, acc) do
    column_to_int(rest, acc * 26 + (char - ?A) + 1)
  end

  def column_to_int_with_recursion(column \\ "A") do
    result =
      column
      |> String.to_charlist()
      |> Enum.reduce(0, fn char_code, acc ->
        acc * 26 + (char_code - 65) + 1
      end)

    result - 1
  end
end
