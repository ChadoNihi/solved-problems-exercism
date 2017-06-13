defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
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
