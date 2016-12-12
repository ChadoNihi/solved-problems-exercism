defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    if Enum.count(strand1) !== Enum.count(strand2) do
      {:error, "Lists must be the same length"}
    else
      dist = Enum.zip(strand1, strand2)
      |> Enum.reduce(0, fn({n1, n2}, acc) ->
          if n1 !== n2, do: acc+1, else: acc end)
      {:ok, dist}
    end
  end
end
