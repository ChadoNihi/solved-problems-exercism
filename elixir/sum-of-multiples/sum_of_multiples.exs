defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    #Enum.sort(factors)
    if Enum.min(factors) >= limit do
        0
    else
      r = 1..(limit - 1)
      Enum.reduce(r, 0, fn(m, sum) -> step(m, sum, factors) end)
    end
  end

  defp step(m, sum, cands) do
    if Enum.any?(cands, &( rem(m, &1) == 0 )) do
      sum + m
    else
      sum
    end
  end
end
