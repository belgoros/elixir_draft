defmodule Macros.ProhibitWords do
  defmacro prohibit_words(words) do
    quote do
      def forbidden?(word) when is_bitstring(word) do
        word in unquote(words)
      end

      def forbidden?(_), do: false
    end
  end
end
