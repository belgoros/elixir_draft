defmodule Debug.UserPoints do
  # Required to use IEx.pry
  require IEx

  def calculate_bonus(points) do
    bonus =
      points
      |> multiply_points()
      |> apply_threshold()
      |> (fn points ->
            # Add breakpoint here
            IEx.pry()
            round_points(points)
          end).()

    {:ok, bonus}
  end

  defp multiply_points(points) do
    points * 1.5
  end

  defp apply_threshold(points) when points > 1000 do
    1000
  end

  defp apply_threshold(points), do: points

  defp round_points(points) do
    round(points)
  end
end
