defmodule DateTime.Solution do
  @spec shift_days(
          time :: Time.t() | NaiveDateTime.t() | Date.t() | Time.t(),
          amount :: integer()
        ) :: Time.t() | NaiveDateTime.t() | Date.t() | Time.t()

  def shift_days(time, 0), do: time

  def shift_days(%Time{} = time, amount) when is_integer(amount) do
    Time.add(time, days_to_seconds(amount), :second)
  end

  def shift_days(%NaiveDateTime{} = time, amount) when is_integer(amount) do
    NaiveDateTime.add(time, days_to_seconds(amount), :second)
  end

  def shift_days(%Date{} = time, amount) when is_integer(amount) do
    Date.add(time, amount)
  end

  def shift_days(%DateTime{} = time, amount) when is_integer(amount) do
    DateTime.add(time, days_to_seconds(amount), :second)
  end

  defp days_to_seconds(amount) do
    amount * 24 * 60 * 60
  end

  # Or you can implement in a single function using `case` statement to pattern-match the date-time value

  # def shift_days(time, days) do
  #  case time do
  #    %Date{} -> Date.add(time, days)
  #    %DateTime{} -> DateTime.add(time, days * 86_400, :second)
  #    %NaiveDateTime{} -> NaiveDateTime.add(time, days * 86_400, :second)
  #    %Time{} -> Time.add(time, days * 86_400, :second)
  #    _ -> {:error, "Unsupported type"}
  #  end
  # end
end
