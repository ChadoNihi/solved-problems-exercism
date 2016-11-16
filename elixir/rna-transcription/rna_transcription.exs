defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    to_string(dna)
    |> String.graphemes
    |> Enum.map(&(getPairNucleot &1))
    |> Enum.join
    |> to_charlist
  end

  defp getPairNucleot(n) do
    case n do
      "G" -> "C"
      "C" -> "G"
      "T" -> "A"
      "A" -> "U"
    end
  end
end
