defmodule ElixirDraft.Draft do
  def print(state \\ %{}) do
    IO.puts("received state: #{inspect(state)}")
  end
end
