defmodule ElixirDraft.Json.User do

	@derive {Jason.Encoder, only: [:name, :email, :age]}
	defstruct [:name, :email, :age]
end
