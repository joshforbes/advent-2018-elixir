defmodule Part2 do
  def calculate(file_path) do
    find_duplicate_frequency([0], frequency_changes(file_path))
  end

  def frequency_changes(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> Enum.map(fn f -> String.to_integer(f) end)
  end

  def find_duplicate_frequency(frequencies, changes) do
    if has_duplicates?(frequencies) do
      return_duplicate(frequencies, changes)
    else
      to_frequencies(changes, frequencies)
      |> find_duplicate_frequency(changes)
    end
  end

  def return_duplicate(frequencies, changes) do
    Enum.take(frequencies, -length(changes))
    |> Enum.find(fn frequency ->
      duplicated?(frequency, frequencies)
    end)
  end

  def to_frequencies(changes, original) do
    Enum.reduce(changes, original, fn change, acc ->
      acc ++ [List.last(acc) + change]
    end)
  end

  def has_duplicates?(list) do
    length(list) != Enum.uniq(list) |> length
  end

  def duplicated?(item, list) do
    Enum.count(list, &(&1 == item)) > 1
  end
end
