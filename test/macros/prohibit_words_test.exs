defmodule Macros.ProhibitWordsTest do
  use ExUnit.Case

  defmodule Exercise do
    require Macros.ProhibitWords

    Macros.ProhibitWords.prohibit_words(["hello", "world", "foo"])
  end

  test "prohibit_words work" do
    assert Exercise.forbidden?("hello")
    assert Exercise.forbidden?("world")
    assert Exercise.forbidden?("foo")
    refute Exercise.forbidden?("baz")
    refute Exercise.forbidden?(2)
    refute Exercise.forbidden?(%{hello: :world})
  end
end
