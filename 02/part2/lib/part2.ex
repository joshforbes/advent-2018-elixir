defmodule Part2 do
  def common_id(input_file) do
    input_file
    |> read_file
    |> zip_ids
    |> find_matching
  end

  defp read_file(input_file) do
    input_file
    |> File.read!()
    |> String.split("\n")
  end

  defp zip_ids(id_list) do
    id_list
    |> Enum.map(fn id ->
      List.duplicate(id, length(id_list))
      |> Enum.zip(id_list)
      |> Enum.reject(fn id_pair ->
        elem(id_pair, 0) == elem(id_pair, 1)
      end)
    end)
    |> List.flatten()
  end

  def find_matching(id_pairs) do
    id_pairs
    |> Enum.reduce_while("", fn id_pair, acc ->
      matching = matching_characters(id_pair)

      if String.length(matching) == String.length(elem(id_pair, 0)) - 1 do
        {:halt, matching}
      else
        {:cont, acc}
      end
    end)
  end

  defp matching_characters(id_pair) do
    String.myers_difference(elem(id_pair, 0), elem(id_pair, 1))
    |> Keyword.get_values(:eq)
    |> Enum.join()
  end
end
