defmodule ElixirDraft.Draft do

	require IEx

  def print(state \\ %{}) do
		IEx.pry()
    IO.puts("received state: #{inspect(state)}")
  end
end
