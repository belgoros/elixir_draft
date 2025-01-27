defmodule CodeBasics.Solution do
  def distance({:point, x1, y1}, {:point, x2, y2}) do
    x_dist = abs(x1 - x2)
    y_dist = abs(y1 - y2)
    :math.sqrt(:math.pow(x_dist, 2) + :math.pow(y_dist, 2))
  end

  def is_point_inside_circle(point, circle) do
    {:circle, circle_center, r} = circle

    distance = distance(point, circle_center)
    distance < r
  end

  def is_point_inside_rectangle({:point, px, py}, {:rect, {:point, x1, y1}, {:point, x2, y2}}) do
    {left, right} = if x1 <= x2, do: {x1, x2}, else: {x2, x1}
    {top, bottom} = if y1 <= y2, do: {y1, y2}, else: {y2, y1}

    left <= px and px <= right and top <= py and py <= bottom
  end

  # Игра в крестики-нолики
  # {
  #  {:x, :o, :f},
  #  {:f, :o, :f},
  #  {:f, :f, :f}
  # }

  def check_who_win({{c, c, c}, _, _}) when c != :f, do: {:win, c}
  def check_who_win({_, {c, c, c}, _}) when c != :f, do: {:win, c}
  def check_who_win({_, _, {c, c, c}}) when c != :f, do: {:win, c}
  def check_who_win({{c, _, _}, {c, _, _}, {c, _, _}}) when c != :f, do: {:win, c}
  def check_who_win({{_, c, _}, {_, c, _}, {_, c, _}}) when c != :f, do: {:win, c}
  def check_who_win({{_, _, c}, {_, _, c}, {_, _, c}}) when c != :f, do: {:win, c}
  def check_who_win({{c, _, _}, {_, c, _}, {_, _, c}}) when c != :f, do: {:win, c}
  def check_who_win({{_, _, c}, {_, c, _}, {c, _, _}}) when c != :f, do: {:win, c}
  def check_who_win(_), do: :no_win

  def list_length([]), do: 0

  def list_length([_head | tail]), do: 1 + list_length(tail)

  def list_max([]), do: nil
  def list_max([elem]), do: elem

  def list_max([head | tail]) do
    max(head, list_max(tail))
  end

  # Solution.range(1, 5) #=> [1, 2, 3, 4, 5]
  # Solution.range(2, 2) #=> [2]
  # Solution.range(3, 2) #=> []
  def range(from, to) when from <= to do
    [from | range(from + 1, to)]
  end

  def range(_, _), do: []

  # To filter adults from a list of users using recursion with accumulator

  # users = [
  #  {:user, 1, "Bob", 23},
  #  {:user, 2, "Helen", 20},
  #  {:user, 3, "Bill", 15},
  #  {:user, 4, "Kate", 14}
  # ]

  def filter_adults(users), do: filter_adults(users, [])

  # you can just return acc as it is if the order does not matter
  defp filter_adults([], acc), do: Enum.reverse(acc)

  defp filter_adults([user | users], acc) do
    {:user, _, _, age} = user

    if age > 16 do
      filter_adults(users, [user | acc])
    else
      filter_adults(users, acc)
    end
  end

  # Solution.get_id_name(users)
  # => [{1, "Bob"}, {2, "Helen"}, {3, "Bill"}, {4, "Kate"}]

  def get_id_name(users), do: get_id_name(users, [])

  defp get_id_name([], acc), do: Enum.reverse(acc)

  defp get_id_name([user | users], acc) do
    {:user, id, name, _} = user
    get_id_name(users, [{id, name} | acc])
  end

  # Solution.split_teens_and_adults(users)
  # => {[{:user, 3, "Bill", 15}, {:user, 4, "Kate", 14}],
  # =>  [{:user, 1, "Bob", 23}, {:user, 2, "Helen", 20}]}

  def split_teens_and_adults(users), do: split_teens_and_adults(users, {[], []})

  defp split_teens_and_adults([], {teens, adults}) do
    {Enum.reverse(teens), Enum.reverse(adults)}
  end

  defp split_teens_and_adults([user | users], {teens, adults}) do
    {:user, _, _, age} = user

    if age > 16 do
      split_teens_and_adults(users, {teens, [user | adults]})
    else
      split_teens_and_adults(users, {[user | teens], adults})
    end
  end

  # Cesar cypher
  def encode(chars, shift) when is_list(chars) do
    Enum.map(chars, &(&1 + shift))
  end

  def decode(chars, shift) when is_list(chars) do
    Enum.map(chars, &(&1 - shift))
  end

  # Simple calculator
  @operations %{"+" => &(&1 + &2), "-" => &(&1 - &2), "*" => &(&1 * &2), "/" => &(&1 / &2)}

  def calculate(operation, arg1, arg2) do
    Map.get(@operations, operation).(arg1, arg2)
  end

  # Simple zip function accepting two arrays
  def zip([], []), do: []

  def zip(first, second) do
    len = max(length(first), length(second))
    range = 0..(len - 1)

    Enum.map(range, fn index ->
      [Enum.at(first, index), Enum.at(second, index)]
    end)
  end

  # Use reduce
  def max_delta([], []), do: 0

  def max_delta(first, second) do
    Enum.zip(first, second)
    |> Enum.reduce(0, fn {x, y}, acc ->
      diff = abs(x - y)
      max(acc, diff)
    end)
  end

  # use comprehensions
  # employees = [
  #  %{
  #    name: "Eric",
  #    status: :active,
  #    hobbies: [%{name: "Text Adventures", type: :gaming}, %{name: "Chickens", type: :animals}]
  #  },
  #  %{
  #    name: "Mitch",
  #    status: :former,
  #    hobbies: [%{name: "Woodworking", type: :making}, %{name: "Homebrewing", type: :making}]
  #  },
  #  %{
  #    name: "Greg",
  #    status: :active,
  #    hobbies: [
  #      %{name: "Dungeons & Dragons", type: :gaming},
  #      %{name: "Woodworking", type: :making}
  #    ]
  #  }
  # ]

  def fetch_gamers(employees) do
    for employee <- employees,
        employee.status == :active,
        hobby <- employee.hobbies,
        hobby.type == :gaming do
      {employee.name, hobby}
    end
  end

  # Use lazy processing with Streams
  def generate(number) do
    Stream.repeatedly(fn -> Enum.random(1..20) end) |> Enum.take(number)
  end

  defmodule User do
    defstruct name: "John"
  end

  defmodule Pet do
    defstruct name: "Barkley"
  end

  @default_stats %{humans: 0, pets: 0}

  # Calculate stats for humans and pets in a list
  def calculate_stats([]), do: @default_stats

  def calculate_stats(humans_and_pets) do
    Enum.reduce(humans_and_pets, @default_stats, &stat_member/2)
  end

  defp stat_member(%User{}, acc) do
    Map.update(acc, :humans, 0, fn curr -> curr + 1 end)
  end

  defp stat_member(%Pet{}, acc) do
    Map.update(acc, :pets, 0, fn curr -> curr + 1 end)
  end

  def validate(str) when is_binary(str) do
    with {:ok, _} <- validate_length(str) do
      {:ok, str}
    end
  end

  def validate(_), do: {:error, :not_binary}

  defp validate_length(str) do
    cond do
      String.length(str) > 8 -> {:error, :too_long}
      String.length(str) < 2 -> {:error, :too_short}
      true -> {:ok, str}
    end
  end
end
