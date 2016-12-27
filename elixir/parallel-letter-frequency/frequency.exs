defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    text = Enum.join(texts)

    if String.length(text) >= workers do
      String.graphemes(text)
      |> Enum.chunk(workers)
      |> Enum.map(&Task.async(&(get_letter_freqs(&1))))
      |> Enum.map(&Task.await(&1))
    else

    end
  end

  defp get_letter_freqs(l) do
    Enum.reduce(l, %{}, &( Map.update ))
  end
end
