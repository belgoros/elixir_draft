defmodule OTP.Accumulator do
  alias OTP.AccumulatorCalculator
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def current do
    Agent.get(__MODULE__, & &1)
  end

  def add(number) when is_number(number) do
    update(:+, number)
  end

  def sub(number) when is_number(number) do
    update(:-, number)
  end

  def mul(number) when is_number(number) do
    update(:*, number)
  end

  def div(number) when is_number(number) do
    update(:/, number)
  end

  def reset, do: mul(0)

  defp update(operation, operator) do
    Agent.update(__MODULE__, fn state ->
      run_calculator_task(operation, state, operator)
    end)
  end

  defp run_calculator_task(operation, a, b) do
    Task.async(fn -> AccumulatorCalculator.exec(operation, a, b) end) |> Task.await()
  end
end
