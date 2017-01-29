defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, rails) do
    rows_map = String.graphemes(str)
    |> Enum.with_index
    |> List.foldr(%{}, fn({gr, i}, rows) ->
      Map.update(rows, rem(i, rails*2 - 2), [gr], fn(row) -> [gr | row] end)
    end)

    Enum.map(0..(rails-1), &(rows_map[&1]))
    |> List.flatten
    |> Enum.join
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, rails) do

  end
end
