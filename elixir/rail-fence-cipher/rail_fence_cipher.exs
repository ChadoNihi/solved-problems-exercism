defmodule RailFenceCipher do
  require Integer
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, rails) do
    rows_map = String.graphemes(str)
    |> Enum.with_index
    |> IO.inspect
    |> List.foldr(%{}, fn({gr, i}, rows) ->
      Map.update(
        rows,
        (if rem(i, rails) == 0 and Integer.is_odd(div(i, rails)), do: rails - rem(i, rails)-1, else: rem(i, rails)),
        [gr],
        fn(row) -> [gr | row] end
      )
    end)

    Enum.map(0..(rails-1), &(rows_map[&1]))
    |> IO.inspect
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
