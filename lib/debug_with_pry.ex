defmodule DebugWithPry do
	#require IEx

	def run(key) when key in [:create, :update] do
		#IEx.pry()
		IO.puts "key received: #{key}"
	end
end

#DebugWithPry.run(:create)
