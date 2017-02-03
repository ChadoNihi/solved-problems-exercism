defmodule RailFenceCipher do
  require Integer
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, 1), do: str
  def encode(str, rails) do
    {rows_map, _, _} = String.graphemes(str)
    |> Enum.reduce({%{}, 0, -1}, fn(gr, {rows, r, r_step}) ->
      curr_r_step = (if r === 0 or r === rails-1, do: -r_step, else: r_step)
      {
        Map.update(
          rows,
          r,
          [gr],
          fn(row) -> [gr | row] end
        ),
        r + curr_r_step,
        curr_r_step
      }
    end)

    Enum.map(0..(rails-1), fn(r) -> if rows_map[r], do: rows_map[r] |> Enum.reverse end)
    |> List.flatten
    |> Enum.join
  end

  defp make_row(_, 1, letters), do: letters
  defp make_row(r, rails, letters) do
    step = (rails-1)*2 - (if r > div(rails-1, 2), do: rails-r-1, else: r) * 2
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
