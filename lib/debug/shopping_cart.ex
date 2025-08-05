defmodule Debug.ShoppingCart do
  defstruct items: [], discounts: [], total: 0

  def new, do: %__MODULE__{}

  def add_item(cart, item) do
    # Debug point 1
    require IEx
    IEx.pry()

    %{cart | items: [item | cart.items]}
    |> calculate_total()
    |> apply_discounts()
  end

  def calculate_total(%{items: items} = cart) do
    total =
      Enum.reduce(items, 0, fn
        %{price: price, quantity: quantity}, acc ->
          acc + price * quantity
      end)

    %{cart | total: total}
  end

  def apply_discounts(%{total: total, items: items} = cart) do
    # Debug point 2
    require IEx
    IEx.pry()

    discounts = [
      quantity_discount(items),
      total_discount(total)
    ]

    %{cart | discounts: discounts, total: apply_discount_values(total, discounts)}
  end

  defp quantity_discount(items) do
    total_quantity = Enum.reduce(items, 0, &(&1.quantity + &2))

    case total_quantity do
      q when q >= 5 -> {:quantity, 0.1}
      _ -> {:quantity, 0}
    end
  end

  defp total_discount(total) do
    case total do
      t when t >= 100 -> {:total, 0.15}
      _ -> {:total, 0}
    end
  end

  defp apply_discount_values(total, discounts) do
    Enum.reduce(discounts, total, fn
      {_type, value}, acc -> acc * (1 - value)
    end)
  end
end
