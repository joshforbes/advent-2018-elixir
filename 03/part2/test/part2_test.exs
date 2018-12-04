defmodule Part2Test do
  use ExUnit.Case
  doctest Part2

  test "finds claim with no overlap" do
    assert Part2.no_overlap("input.txt") == 3
  end
end
