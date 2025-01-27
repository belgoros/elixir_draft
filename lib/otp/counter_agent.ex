defmodule OTP.CounterAgent do
  @moduledoc false

  use Agent

  @default_name CounterAgent

  defmodule State do
    @moduledoc false
    defstruct create_user: 0, update_user: 0, find_user: 0, list_users: 0
  end

  def start_link do
    Agent.start_link(fn -> %State{} end, name: @default_name)
  end

  def increment(name \\ @default_name, request_type) do
    Agent.update(name, fn state -> Map.update!(state, request_type, &(&1 + 1)) end)
  end

  def reset(name \\ @default_name) do
    Agent.update(name, fn _state -> %State{} end)
  end

  def hits_count(name \\ @default_name, request_type) do
    Agent.get(name, fn state -> Map.fetch!(state, request_type) end)
  end
end
