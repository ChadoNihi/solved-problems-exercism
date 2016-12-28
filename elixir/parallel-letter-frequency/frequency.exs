defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    l_of_all_chars = Enum.join(texts)
    |> String.downcase
    |> String.graphemes

    if Enum.count(l_of_all_chars) >= workers do
      Enum.chunk(l_of_all_chars, workers)
      |> Enum.map(&Task.async(fn() -> get_letter_freqs(&1) end))
      |> Enum.map(&Task.await(&1))
      |> Enum.reduce(fn(map, acc) -> Map.merge(acc, map, fn(_, v1, v2) -> v1+v2 end) end)
    else
      get_letter_freqs(l_of_all_chars)
    end
  end

  @pattern ~r/\w/u
  @pattern_digit ~r/\d/
  defp get_letter_freqs(l) do
    Enum.filter(l, fn(ch) -> String.match?(ch, @pattern) and ! String.match?(ch, @pattern_digit) end)
    |> Enum.reduce(%{}, fn(ch, acc) -> Map.update(acc, ch, 1, &(&1+1)) end)
  end
end
