defmodule OTP.BasicServer do
	use GenServer

	# Client

  def start_link(default) when is_binary(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # Server (callbacks)

  @impl true
  def init(old_state) do
    initial_state = String.split(old_state, ",", trim: true)
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:pop, _from, old_state) do
    [to_caller | new_state] = old_state
    {:reply, to_caller, new_state}
  end

  @impl true
  def handle_cast({:push, new_state}, old_state) do
    new_state = [new_state | old_state]
    {:noreply, new_state}
  end
end
