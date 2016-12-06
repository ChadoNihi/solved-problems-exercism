defmodule Prime do
  require Integer
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when n <=0 do
    raise "invalid number"
  end
  def nth(1), do: 2
  def nth(n) do
    _nth(n, 1, 3)
  end

  defp _nth(n, n, cand) , do: cand-2
  defp _nth(n, cnt, cand) do
    if is_prime(cand) do
      _nth(n, cnt+1, cand+2)
    else
      _nth(n, cnt, cand+2)
    end
  end

  defp is_prime(x), do: is_prime(x, 3, Float.floor(:math.sqrt(x)))

  defp is_prime(_, cand_factor, till) when cand_factor > till, do: true
  defp is_prime(x, cand_factor, till) do
    if rem(x, cand_factor) == 0 do
      false
    else
      is_prime(x, cand_factor+2, till)
    end
  end
end
