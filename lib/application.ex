defmodule ElixirDraft.Application do
  use Application

  def start(_type, _args) do
    # ElixirDraft.NaturalNums.print(3)
    {:ok, self()}
  end
end
