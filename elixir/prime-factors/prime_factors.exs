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

  def primes_to(limit) do
    sieve_step(%{}, 2, limit)
    |> Enum.reduce([], fn({num, is_prime}, primes) -> if is_prime, do: [num | primes], else: primes end)
    |> Enum.sort
  end

  defp sieve_step(primes, prime, limit) do
    primes = Map.put(primes, prime, true)
    |> mark_multiples(prime, limit)

    next_prime = find_next_prime(primes, prime)

    if next_prime > limit do
      primes
    else
      sieve_step(primes, next_prime, limit)
    end
  end

  defp mark_multiples(primes, prime, limit), do: mark_multiples(primes, prime, prime+prime, limit)
  defp mark_multiples(primes, _prime, curr, limit) when curr > limit, do: primes
  defp mark_multiples(primes, prime, curr, limit) do
    mark_multiples(Map.put(primes, curr, false), prime, curr+prime, limit)
  end

  defp find_next_prime(_primes, 2), do: 3
  defp find_next_prime(primes, key) do
    next_key = key+2
    if Map.get(primes, next_key, true) do
      next_key
    else
      find_next_prime(primes, next_key)
    end
  end
end
