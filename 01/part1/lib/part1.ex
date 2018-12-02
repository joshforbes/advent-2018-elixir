defmodule Part1 do
  def calculate(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> Enum.map(fn f -> String.to_integer(f) end)
    |> Enum.sum()
  end
end
