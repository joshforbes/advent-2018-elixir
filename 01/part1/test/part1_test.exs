defmodule Part1Test do
  use ExUnit.Case
  doctest Part1

  test "it reads a file and sums the lines" do
    result = Part1.calculate("test/frequency_fixture.txt")

    assert result == 2
  end
end
