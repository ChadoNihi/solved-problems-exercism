defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    String.split(sentence, [" ", ", ", "_", " : "])
      |> Enum.map(fn w -> Regex.replace(~r/[!&@$%^?]+$/, String.downcase(w), "") end)
      |> Enum.reduce(%{}, fn(w, acc) -> Map.update(acc, w, 1, &(&1 + 1)) end)
  end
end
