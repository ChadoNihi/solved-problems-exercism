defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    coin_types = Enum.sort(values, &(&1 > &2))

    if Enum.empty?(coin_types) or Enum.min(coin_types) > amount do
      :error
    else
      coins = Map.new(coin_types, &{&1, 0})
      min_change(amount, coin_types, coins)
    end
  end

  defp min_change(0, _, coins), do: {:ok, coins}
  defp min_change(_, [], _), do: :error
  defp min_change(amount, [coin | rest], coins) when coin > amount do
    min_change(amount, rest, coins)
  end
  defp min_change(amount, [coin | rest] = coin_types, coins) do
    rem = amount - coin

    if Enum.any?(coin_types, &(rem(rem, &1)==0)) do
      min_change(rem, coin_types, Map.update!(coins, coin, &(&1 + 1)))
    else
      min_change(amount, rest, coins)
    end
  end
end
