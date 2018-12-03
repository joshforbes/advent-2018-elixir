defmodule Part1Test do
  use ExUnit.Case
  doctest Part1

  test "calculates a checksum" do
    result = Part1.checksum("test/box_id_fixture.txt")

    assert result == 12
  end
end
