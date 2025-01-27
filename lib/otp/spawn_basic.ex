defmodule OTP.SpawnBasic do
	def greet(counter \\ 0) do
		#counter = 0
		receive do
			{sender, msg} ->
				counter = counter + 1
				send sender, {:ok, "Hello, #{msg}! Counter: #{counter}"}
				greet()
		end
	end
end

# here's a client
pid = spawn(OTP.SpawnBasic, :greet, [])
send pid, {self(), "World!"}
receive do
	{:ok, message} ->
		IO.puts message
end

send pid, {self(), "Kermit!"}
receive do
	{:ok, message} ->
		IO.puts message
after 500 ->
	IO.puts "The greeter has gone away"
end
