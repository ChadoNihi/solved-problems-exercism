defmodule Prime do
  require Integer
  @doc """
  Generates the nth prime.
  """
  @fstFivePrimes [2,3,5,7,11,13]

  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when n <=0 do
    raise "invalid number"
  end
  def nth(n) do
    if n < 7 do
      Enum.at(@fstFivePrimes, n-1)
    else
      startingCand = round(n*:math.log(n) + n*(:math.log(:math.log(n))-1))
      findPrimeStartingFromOdd( if Integer.is_even(startingCand), do: startingCand+1, else: startingCand )
    end
  end

  defp findPrimeStartingFromOdd(cand) do
    if isPrime(cand) do
      cand
    else
      findPrimeStartingFromOdd(cand+2)
    end
  end

  defp isPrime(x) do
    Integer.is_odd(x) and
    testFactors(3, x, x)
  end

  defp testFactors(f, bound, pr) when f > bound, do: true
  defp testFactors(f, bound, pr) do
    if rem(pr, f) == 0 do
      false
    else
      testFactors(f+2, bound, pr)
    end
  end
end
