defmodule Part1 do
  def overlap(file_input) do
    file_input
    |> read_file
    |> build_claims
    |> plot_coordinates
    |> Enum.count(fn {_, count} -> count > 1 end)
  end

  defp read_file(input_file) do
    input_file
    |> File.read!()
    |> String.split("\n")
  end

  def build_claims(claims) do
    claims
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [id, "@", coordinate, size] ->
      id = id |> String.trim("#")

      coordinate =
        coordinate
        |> String.trim(":")
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()

      size = size |> String.split("x") |> Enum.map(&String.to_integer/1) |> List.to_tuple()

      %{id: id, coordinate: coordinate, size: size}
    end)
  end

  def plot_coordinates(claims) do
    claims
    |> Enum.reduce(%{}, fn %{coordinate: coordinate, size: size, id: _}, acc ->
      plot(coordinate, size)
      |> Enum.reduce(acc, fn coordinates, acc ->
        Map.update(acc, coordinates, 1, fn x -> x + 1 end)
      end)
    end)
  end

  def plot({x, y}, {width, height}) do
    for x <- x..(x + width - 1), y <- y..(y + height - 1), do: {x, y}
  end
end
