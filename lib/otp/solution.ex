defmodule OTP.Solution do
  alias OTP.Worker

  def supervise_foobar(initial_number) do
    Process.flag(:trap_exit, true)
    call_worker(initial_number)

    initial_number |> supervise() |> String.trim()
  end

  defp supervise(number) do
    receive do
      {:EXIT, _, :foobar} -> process_next("FooBar", number)
      {:EXIT, _, :foo} -> process_next("Foo", number)
      {:EXIT, _, :bar} -> process_next("Bar", number)
      {:EXIT, _, :normal} -> process_next("", number)
    end
  end

  defp process_next(_, number) when number > 100, do: ""
  defp process_next(_, number) when number < 1, do: ""

  defp process_next("", number) do
    next_number = number + 1
    call_worker(next_number)
    supervise(next_number)
  end

  defp process_next(text, number) do
    next_number = number + 1
    call_worker(next_number)
    "#{text} #{supervise(next_number)}"
  end

  defp call_worker(number) do
    spawn_link(fn -> Worker.work(number) end)
  end
end
