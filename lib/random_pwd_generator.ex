defmodule ElixirDraft.RandomPwdGenerator do
	def generate() do
		[?A..?Z, ?a..?z, ?0..?9] |> Enum.concat() |> Enum.take_random(12) |> List.to_string()
	end
end
