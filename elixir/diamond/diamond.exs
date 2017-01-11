defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(ch) when ch >= ?a and ch <= ?z, do: build_shape(ch - (?a-?A))
  def build_shape(ch) when ch < ?A or ch > ?Z, do: raise ArgumentError
  def build_shape(max_ch) do
    half = Enum.reduce(max_ch..?A, [], fn(ch, acc) -> [make_row(ch, max_ch-ch) | acc] end)
    half ++ (Enum.reverse(half) |> tl)
    |> Enum.join
  end

  defp make_row(ch, n_outer) do
    outer_spaces = List.duplicate(" ", n_outer)
    ch_str = ch_to_str(ch)

    if ch === ?A do
      [outer_spaces | [ch_str | outer_spaces++["\n"]]]
    else
      [outer_spaces | [ch_str | [List.duplicate(" ", (ch-?A)*2-1) | [ch_str | outer_spaces++["\n"]]]]]
    end
    |> Enum.join
  end

  defp ch_to_str(ch) do
    case ch do
      ?A -> "A"
      ?B -> "B"
      ?C -> "C"
      ?D -> "D"
      ?E -> "E"
      ?F -> "F"
      ?G -> "G"
      ?H -> "H"
      ?I -> "I"
      ?J -> "J"
      ?K -> "K"
      ?L -> "L"
      ?M -> "M"
      ?N -> "N"
      ?O -> "O"
      ?P -> "P"
      ?Q -> "Q"
      ?R -> "R"
      ?S -> "S"
      ?T -> "T"
      ?U -> "U"
      ?V -> "V"
      ?W -> "W"
      ?X -> "X"
      ?Y -> "Y"
      ?Z -> "Z"
      true -> "?"
    end
  end
end
