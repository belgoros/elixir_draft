defmodule OTP.AccumulatorTest do
  use ExUnit.Case
  alias OTP.Accumulator

  test "accumulator agent" do
    Accumulator.start_link(0)

    Accumulator.add(10)
    assert Accumulator.current() == 10
    Accumulator.add(3)
    assert Accumulator.current() == 13

    Accumulator.mul(10)
    assert Accumulator.current() == 130
    Accumulator.mul(3)
    assert Accumulator.current() == 390

    Accumulator.sub(10)
    assert Accumulator.current() == 380
    Accumulator.sub(3)
    assert Accumulator.current() == 377

    Accumulator.div(10)
    assert Accumulator.current() == 37
    Accumulator.div(3)
    assert Accumulator.current() == 12

    Accumulator.reset()
    assert Accumulator.current() == 0
    assert Agent.stop(Accumulator) == :ok
  end
end
