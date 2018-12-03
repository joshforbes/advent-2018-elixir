defmodule Part2Test do
  use ExUnit.Case
  doctest Part2

  test "finds the matching characters" do
    result = Part2.common_id("test/box_id_fixture.txt")

    assert result == "fgij"
  end
end
