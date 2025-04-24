defmodule ElixirDraft.Files.CsvLoader do
  require Logger
	
	@data_file "/Users/scambour/Downloads/applied_jobs/Applied in person-Table 1.csv"
	
	def load_file do
		load(@data_file)
	end

  def load(file) do
    Logger.info("Loading data from file: #{file}")

    case File.read(file) do
      {:ok, data} ->
        Logger.info("File reading in progress...")
        records = String.split(data, ";", trim: true)
				IO.inspect(records)
        {:ok, records}

      {:error, reason} ->
        Logger.warning("File reading failed: #{reason}")
        {:error, reason}
    end
  end
end