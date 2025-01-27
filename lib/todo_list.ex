defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new, do: %TodoList{}

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries =
      Map.put(
        todo_list.entries,
        todo_list.auto_id,
        entry
      )

    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def delete_entry(todo_list, entry_id) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end
end

defmodule TodoList.CSVImporter do
  def import(csv_file) do
    todo_list = TodoList.new()

    csv_file
    |> File.stream!()
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.each(fn line -> process_line(todo_list, line) end)
  end

  defp process_line(todo_list, line) do
    split_values =
      line
      |> split_line()

    date = convert_to_date(split_values)
    title = extract_title(split_values)

    TodoList.add_entry(todo_list, %{date: date, title: title})
  end

  defp split_line(line) do
    String.split(line, ",")
  end

  defp convert_to_date(split_line) do
    {year, month, day} =
      split_line
      |> List.first()
      |> String.split("/")
      |> Enum.map(&String.to_integer(&1))
      |> List.to_tuple()

    Date.new!(year, month, day)
  end

  defp extract_title(split_line) do
    split_line
    |> List.last()
  end
end
