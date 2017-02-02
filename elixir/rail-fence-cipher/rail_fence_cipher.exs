defmodule RailFenceCipher do
  require Integer
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, rails) do
    letters = String.graphemes(str)

    Enum.reduce((rails-1)..0, [], fn(r, rows) -> [make_row(r, rails, letters) | rows] end)
    |> List.flatten
    |> Enum.join

    # {rows_map, _} = String.graphemes(str)
    # |> Enum.with_index
    # |> Enum.reduce({%{}, true}, fn({gr, i}, {rows, is_down}) ->
    #   r = rem(i-div(i+1,rails), rails)
    #   {Map.update(
    #     rows,
    #     (if is_down, do: r, else: rails - r - 1),
    #     [gr],
    #     fn(row) -> row++[gr] end
    #   ), (if i > 0 and (r == 0 or r == rails-1), do: !is_down, else: is_down)}
    # end)
    #
    # Enum.map(0..(rails-1), &(rows_map[&1]))
    # |> IO.inspect
    # |> List.flatten
    # |> Enum.join
  end

  defp make_row(r, rails, letters) do
    step = rails + (rails-1)*2 - (if r > div(rails, 2), do: rails-r-1, else: r) * 2
    Enum.drop(letters, r)
    |> Enum.take_every(step)
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, rails) do

  end
end
