defmodule ElixirDraft.Draft do
  def print() do
    guess = "1"
    number_to_guess = 10

    message =
      case guess do
        ^number_to_guess -> "yay, you win with the correct answer of: #{number_to_guess}"
        _ -> "Your guess: #{guess}. Wrong. Guess again. "
      end

    IO.puts(message)
  end
end
