defprotocol CodeBasics.Teller do
  @spec say_something(any()) :: String.t()
  def say_something(someone)
end

defmodule CodeBasics.Human do
  defstruct [:name]
end

defmodule CodeBasics.Dog do
  defstruct [:name]
end

defmodule CodeBasics.Cat do
  defstruct [:name]
end

defimpl CodeBasics.Teller, for: CodeBasics.Human do
  def say_something(_someone), do: "Hello, world"
end

defimpl CodeBasics.Teller, for: CodeBasics.Dog do
  def say_something(_someone), do: "Bark, world"
end

defimpl CodeBasics.Teller, for: CodeBasics.Cat do
  def say_something(_someone), do: "Meow, world"
end

defimpl CodeBasics.Teller, for: Any do
  def say_something(_), do: "World!"
end

defmodule CodeBasics.Robot do
  @derive [CodeBasics.Teller]
  defstruct [:name]
end


