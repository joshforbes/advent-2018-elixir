defmodule Part2 do
  def no_overlap(file_input) do
    claims = file_input |> read_file |> build_claims
    coordinates_claimed = claims |> plot_coordinates

    untouched_claim =
      Enum.find(claims, fn claim ->
        touched?(claim, coordinates_claimed)
      end)

    untouched_claim[:id] |> String.to_integer()
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

  def touched?(%{coordinate: coordinate, size: size}, claims) do
    plot(coordinate, size)
    |> Enum.all?(fn coordinate -> claims[coordinate] == 1 end)
  end
end
