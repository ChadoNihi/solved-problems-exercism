defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    Enum.reduce(max_factor..min_factor, %{}, fn(fac1, pal_to_pairs) ->
      Enum.reduce(fac1..min_factor, pal_to_pairs, fn(fac2, pal_to_pairs) ->
        prod = fac1*fac2
        digs = Integer.digits(prod)
        if digs == Enum.reverse(digs) do
          Map.update(pal_to_pairs, prod, [[fac2,fac1]], &(  [[fac2,fac1] | &1]  ))
        else
          pal_to_pairs
        end
      end)
    end)
  end
end
