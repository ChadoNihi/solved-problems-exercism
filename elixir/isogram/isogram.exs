defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    chars = String.graphemes(sentence)
    |> Enum.filter(&(&1 !== " " and &1 !== "-"))

    Enum.count(chars) == MapSet.new(chars)
    |> MapSet.size
  end

end
