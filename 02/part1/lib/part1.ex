defmodule Part1 do
  def checksum(input_file) do
    counts =
      input_file
      |> read_file
      |> Enum.reduce(%{two: 0, three: 0}, fn id, acc ->
        if has_exactly(2, id) do
          acc = Map.update!(acc, :two, &(&1 + 1))
        end

        if has_exactly(3, id) do
          acc = Map.update!(acc, :three, &(&1 + 1))
        end

        acc
      end)

    counts[:two] * counts[:three]
  end

  defp read_file(input_file) do
    input_file
    |> File.read!()
    |> String.split("\n")
  end

  defp has_exactly(count, id) do
    id_graphememes = id |> String.graphemes()

    id_graphememes
    |> Enum.reduce_while(false, fn character, acc ->
      if Enum.count(id_graphememes, &(&1 == character)) == count do
        {:halt, true}
      else
        {:cont, false}
      end
    end)
  end
end
