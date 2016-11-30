defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  fstFivePrimes = [2,3,5,7,11]

  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) do
    if n < 6 do
      Enum.at(fstFivePrimes, n-1)
    else
      startingCand = round(n*ln(n) + n*(ln(ln(n))-1))
      findPrimeStartingFrom( if Integer.is_even(startingCand), do: startingCand+1, else: startingCand )
    end
  end

  defp findPrimeStartingFrom(cand) do
    
  end

  defp ln(x) do
    :math.log10(x) * :math.log10(2.718281828459045)
    |> round
  end
end
