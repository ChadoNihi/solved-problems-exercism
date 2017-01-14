defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    Enum.reduce_while(primes_up_to(number |> round), %{fs: [], num: number}, fn(pr, acc) ->
      {prs, num} = process_cand_fc(pr, number)
      if num === 1 do
        {:halt, Map.update!(acc, :fs, &(Enum.concat(&1, prs)))}
      else
        {:cont, Map.update!(acc, :fs, &(Enum.concat(&1, prs)))
          |> Map.put(:num, num)
        }
      end
    end)
    |> Map.get(:fs)
  end

  defp process_cand_fc(pr, num, prs \\ []) do
    if rem(num, pr) === 0 do
      process_cand_fc(pr, div(num, pr), [pr | prs])
    else
      {prs, num}
    end
  end

  defp primes_up_to(max) do
    primes_up_to(max, [2], 3)
  end
  defp primes_up_to(max, _, _) when max < 2, do: []
  defp primes_up_to(max, prs, cand) when max < cand, do: Enum.reverse(prs)
  defp primes_up_to(max, prs, cand) do
    if is_prime(cand) do
      primes_up_to(max, [cand | prs], cand+2)
    else
      primes_up_to(max, prs, cand+2)
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
