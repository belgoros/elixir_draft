defmodule Macros.HygienicMacro do
  defmacro with_logging(do: function) do
    quote do
      IO.puts("Started execution...")
      result = unquote(function).()
      IO.puts("Execution result is: #{inspect(result)}")
      result
    end
  end
end
