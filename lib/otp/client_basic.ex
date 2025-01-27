defmodule OTP.ClientBasic do
	alias OTP.SpawnBasic

	def run do
		pid = spawn(SpawnBasic, :greet, [])
		send pid, {self(), "World"}

		receive do
			{:ok, msg} ->
				IO.puts "Received a message: #{msg}"
		end
	end
end
