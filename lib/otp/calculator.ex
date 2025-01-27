defmodule OTP.Calculator do
  def calculate(pid) do
    receive do
      {operation, args} ->
        send(pid, {:ok, exec(operation, args)})
        calculate(pid)

      {:exit} ->
        send(pid, {:ok, :exited})
    end
  end

  defp exec(:+, [first, second]) do
    first + second
  end

  defp exec(:-, [first, second]) do
    first - second
  end

  defp exec(:*, [first, second]) do
    first * second
  end
end
