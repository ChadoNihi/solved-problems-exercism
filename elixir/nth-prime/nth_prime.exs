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
      
    end
  end

end
