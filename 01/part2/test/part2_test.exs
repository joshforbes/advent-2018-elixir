defmodule Part2Test do
  use ExUnit.Case
  doctest Part2

  test "it reads a file and sums the lines" do
    result = Part2.calculate("input.txt")

    assert result == 14
  end
end
