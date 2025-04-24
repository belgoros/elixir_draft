defmodule ElixirDraft.Files.CsvLoader do
  require Logger
	
	alias Files.FileReader

  def load(file) do
    Logger.info("Loading data from file: #{file}")

    case FileReader.read_csv(file) do
			{:ok, data} -> {:ok, data}
			{:error, reason} -> {:error, reason}
		end
  end
end