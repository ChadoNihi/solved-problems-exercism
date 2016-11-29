defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    String.upcase(word)
    |> String.graphemes
    |> Enum.filter(fn ch -> String.match?(ch, ~r/[A-Z]/) end)
    |> Enum.reduce(0, fn ch, score -> score + chToScore(ch) end)
  end

  defp chToScore ch do
    cond do
      String.match?(ch, ~r/[AEIOULNRST]/) ->
        1
      ch == "D" || ch == "G" ->
        2
      String.match?(ch, ~r/[BCMP]/) ->
        3
      String.match?(ch, ~r/[FHVWY]/) ->
        4
      ch == "K" ->
        5
      ch == "J" || ch == "X" ->
        8
      ch == "Q" || ch == "Z" ->
        10
      true ->
        0
    end
  end
end
