defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(str) do
    norm_letters = String.downcase(str)
    |> String.graphemes
    |> Enum.filter(&(String.match?(&1, ~r/^[a-z0-9]$/)))

    n_cols = :math.sqrt(length(norm_letters)) |> Float.ceil |> round

    Enum.chunk(norm_letters, n_cols, n_cols, List.duplicate(" ", n_cols))
    |> Enum.zip
    |> List.foldr([], fn(code_row, acc) ->
      [
        Tuple.to_list(code_row) |
        [(if elem(code_row, tuple_size(code_row)-1)==" ", do: "", else: " ") | acc]
      ]
    end)
    |> List.flatten
    |> Enum.join
    |> String.trim_trailing
  end
end
