defmodule CodeBasics.WithClause do
  def happy_path(x) do
    with {:ok, a} <- build_a(x),
         {:ok, b} <- build_b(a),
         {:ok, c} <- build_c(b) do
      {:ok, {a, b, c}}
    end
  end

  defp build_a(a) do
    {:ok, a + 1}
  end

  defp build_b(b) do
    {:ok, b + 1}
  end

  defp build_c(c) do
    {:ok, c + 1}
  end
end
