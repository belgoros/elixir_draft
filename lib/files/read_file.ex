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
end
