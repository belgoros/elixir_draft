defmodule ElixirDraft.Json.JsonReader do
	alias ElixirDraft.Json.User

	def to_json(%User{} = user) do
		Jason.encode!(user)
	end

	def to_model(json) do
		Jason.decode!(json)
	end
end
