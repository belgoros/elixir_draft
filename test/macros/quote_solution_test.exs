defmodule Macros.QuoteSolutionTest do
  use ExUnit.Case

  require Macros.QuoteSolution
  alias Macros.QuoteSolution

  test "my_unless work" do
    assert QuoteSolution.my_unless(false, do: 1 + 3) == 4
    refute QuoteSolution.my_unless(true, do: 2)
    refute QuoteSolution.my_unless(2 == 2, do: "Hello")
    assert QuoteSolution.my_unless(1 == 2, do: "world") == "world"
  end
end
