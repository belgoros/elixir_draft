defmodule DocxReader do
  import SweetXml

  def extract_text(docx_path) do
    # Ensure file exists before attempting to unzip
    if not File.exists?(docx_path) do
      {:error, "File not found: #{docx_path}"}
    else
      case :zip.unzip(String.to_charlist(docx_path), [:memory]) do
        {:ok, files} ->
          case Enum.find(files, fn {path, _} -> path == ~c"word/document.xml" end) do
            {~c"word/document.xml", xml_content} ->
              {:ok, parse_text(xml_content)}

            _ ->
              {:error, "word/document.xml not found"}
          end

        {:error, reason} ->
          {:error, "Failed to unzip: #{inspect(reason)}"}
      end
    end
  end

  defp parse_text(xml_content) do
    xml_content
    # Extract all text nodes inside <w:t>
    |> xpath(~x"//w:t/text()"l)
    # Join them into a single string
    |> Enum.join(" ")
  end
end

# Usage example in an iex session
# docx_path = Path.join(:code.priv_dir(:elixir_draft), "documents/example.docx")

# case DocxReader.extract_text(docx_path) do
#  {:ok, text} -> IO.puts(text)
#  {:error, reason} -> IO.puts("Error: #{reason}")
# end
