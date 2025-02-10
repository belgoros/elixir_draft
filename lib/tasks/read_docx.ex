defmodule Mix.Tasks.ReadDocx do
  use Mix.Task

  @shortdoc "Reads text from a .docx file"

  # Run the task as `mix read_docx` from the CLI
  def run(_) do
    # Ensure the app is started
    Mix.Task.run("app.start")

    docx_path = Path.join(:code.priv_dir(:elixir_draft), "documents/example.docx")

    case DocxReader.extract_text(docx_path) do
      {:ok, text} -> IO.puts(text)
      {:error, reason} -> IO.puts("Error: #{reason}")
    end
  end
end
