defmodule Mix.Tasks.Import.Csv.Data do
  @moduledoc """
    This task imports CSV data into the application.

    Usage:
      mix import.csv.data path/to/file.csv

    Example:
      mix import.csv.data data/users.csv
  """
  use Mix.Task

  alias ElixirDraft.Files.CsvLoader

  @shortdoc "Calls the CsvLoader.load/1 function."
  @impl Mix.Task
  def run(args) do
    # This will start our application
    # Mix.Task.run("app.start")

    case CsvLoader.load(Enum.join(args)) do
      {:ok, data} ->
        IO.puts("Data loaded successfully: \n#{inspect(data)}")

      {:error, reason} ->
        IO.puts("Error loading data: #{reason}")
    end
  end
end
