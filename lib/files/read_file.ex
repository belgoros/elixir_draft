defmodule Files.ReadFile do

	@scraper_data "lib/scraper_data.txt"
	@todos_file "lib/todos.csv"

  def read do
    orig_file = "/path/to/file"
    dest_file = "/path/to/other/file"

    File.stream!(orig_file)
    |> Stream.map(&String.replace(&1, "#", "%"))
    |> Stream.into(File.stream!(dest_file))
    |> Stream.run()
  end

	def read_scraper_data() do
		File.read(@scraper_data)
	end

	def read_csv() do
		{:ok, csv_data} = File.read(@todos_file)
		csv_data
	end

	def read_csv(file_path) do
	    file_path
	    |> File.stream!()
	    |> Stream.drop(1) # Skip the header
	    |> Stream.map(&parse_line/1)
	    |> Enum.to_list()
	  end

	  defp parse_line(line) do
	    line
	    |> String.trim()     # Remove newline characters
	    |> String.split(";") # Split by semicolon
	  end
end
