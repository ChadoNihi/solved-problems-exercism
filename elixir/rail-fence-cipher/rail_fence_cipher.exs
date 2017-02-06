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
    enc_rows = List.foldr(get_row_sizes(chars, rails), {[], chars}, fn(r_sz, {rows, chars_left}) ->
      {row, left} = Enum.split(chars_left, r_sz)
      {
        [row | rows],
        left
      }
    end)
    |> elem(0)

    decode_from_rows(enc_rows, 0, rails-1)
  end

  defp get_row_sizes(chars, rails) do
    freqs = Enum.to_list(0..rails-1) ++ Enum.to_list(rails-2..1)
    |> Stream.cycle
    |> Enum.take(Enum.count(chars))
    |> Enum.reduce(%{}, fn(r, freqs) -> Map.update(freqs, r, 1, &(&1+1)) end)

    Enum.map(0..rails-1, fn(r) -> freqs[r] end)
  end

  defp decode_from_rows(enc_rows, r, max_r) do
    enc_rows_left = Enum.reduce(enc_rows, {%{}, 0}, fn(row, {r_to_row, r}) ->
      {Map.put(r_to_row, r, row), r+1}
    end)
    |> elem(0)

    decode_from_rows(enc_rows_left, r, max_r, 1, [])
  end
  defp decode_from_rows(enc_rows_left, r, max_r, step, acc) do
    if Enum.empty?(enc_rows_left[r]) do
      Enum.reverse(acc) |> Enum.join
    else
      curr_r_step = (if r === 0 or r === max_r, do: -step, else: step)
      decode_from_rows(
        Map.update!(enc_rows_left, r, &(tl(&1))),
        r + curr_r_step,
        max_r,
        curr_r_step,
        [hd(enc_rows_left[r]) | acc]
      )
    end
  end
end
