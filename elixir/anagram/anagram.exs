defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, cands) do
    Enum.filter(cands, &(isAnagram(base, &1)))
  end

  defp isAnagram(base, cand) do
    base = String.downcase(base)
    cand = String.downcase(cand)

    base != cand and
    String.length(base) == String.length(cand) and
    (String.graphemes(base)
    |> Enum.sort()) == (String.graphemes(cand)
    |> Enum.sort())
  end
end
