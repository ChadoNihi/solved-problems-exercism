defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(ch) when ch >= ?a and ch <= ?z, do: build_shape(ch - (?a-?A))
  def build_shape(ch) when ch < ?A or ch > ?Z, do: raise ArgumentError
  def build_shape(max_ch) do
    Enum.reduce(max_ch..?A, [], fn(ch, acc) -> [make_row(ch, max_ch-ch) | acc] end)
  end

  defp make_row(ch, n_outer) do
    outer_spaces = List.duplicate(" ", n_outer)
    [outer_spaces | [ch | [List.duplicate(" ", ch-?A) | [ch | outer_spaces]]]]
  end

  defp ch_to_ do

  end
end
