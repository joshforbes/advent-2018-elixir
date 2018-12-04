defmodule Part1Test do
  use ExUnit.Case
  doctest Part1

  test "calculates overlaping claims" do
    assert Part1.overlap("test/claim_fixture.txt") == 4
  end
end
