defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(str) do
    norm_letters = String.downcase(str)
    |> String.graphemes
    |> Enum.filter(&(String.match?(&1, ~r/^[a-z]$/)))

    row_sz = :math.sqrt(length(norm_letters)) |> Float.ceil |> round

    Enum.chunk(norm_letters, row_sz, row_sz, [])
    |> Enum.intersperse(" ")
    |> List.flatten
    |> Enum.join
  end
end
