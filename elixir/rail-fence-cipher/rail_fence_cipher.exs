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

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, 1), do: str
  def decode(str, rails) do
    chars = String.graphemes(str)
    List.foldr(get_row_sizes(chars, rails), {[], chars}, fn(r_sz, {rows, chars_left}) ->
      {row, left} = Enum.split(chars_left, r_sz)
      {
        [row | rows],
        left
      }
    end)
  end

  defp get_row_sizes(chars, rails) do
    
  end
end
