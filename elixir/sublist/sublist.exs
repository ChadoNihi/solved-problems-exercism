defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    if a == b do
      :equal
    else
      alen = Enum.count(a)
      blen = Enum.count(b)
      cond do
        alen == blen ->
          :unequal
        a == [] ->
          :sublist
        b == [] ->
          :superlist
        alen > blen and contains?(a, b) ->
          :superlist
        blen > alen and contains?(b, a) ->
          :sublist
        true ->
          :unequal
      end
    end
  end

  defp contains?(sup, sub) do
    cond do
      Enum.count(sub) > Enum.count(sup) ->
      false
      Enum.count(sub) == Enum.count(sup) ->
        if sub === sup do
          true
        else
          false
        end
      true ->
        Enum.zip(sup, sub)
        |> Enum.all?(fn {x,y} -> x === y end)
        |> if do
          true
        else
          [_ | t] = sup
          contains?(t, sub)
        end
    end
  end
end
