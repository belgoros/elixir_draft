defmodule OTP.AccumulatorCalculatorTest do
  use ExUnit.Case
  alias OTP.AccumulatorCalculator

  describe "calculator code unchanged" do
    test "adding" do
      assert AccumulatorCalculator.exec(:+, 2, 3) == 5
      assert AccumulatorCalculator.exec(:+, 10, 20) == 30
    end

    test "subtraction" do
      assert AccumulatorCalculator.exec(:-, 2, 3) == -1
      assert AccumulatorCalculator.exec(:-, 10, 20) == -10
    end

    test "multiply" do
      assert AccumulatorCalculator.exec(:*, 2, 3) == 6
      assert AccumulatorCalculator.exec(:*, 10, 20) == 200
    end

    test "division" do
      assert AccumulatorCalculator.exec(:/, 2, 3) == 0
      assert AccumulatorCalculator.exec(:/, 20, 10) == 2
    end
  end
end
