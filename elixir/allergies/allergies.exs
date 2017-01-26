defmodule Allergies do
  use Bitwise, only_operators: true
  @items ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]
  @n length(@items)
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags, item \\ nil) do
    list(flags, [], item)
  end
  def list(_flags, res, item) when hd(res) === item, do: item
  def list(flags, res, _item) when flags < 1, do: res
  def list(flags, res, item) do
    i = max_pow_of_2(flags)
    list(
      flags-round(:math.pow(2,i)),
      (if i >= @n, do: res, else: [Enum.at(@items, i) | res]),
      item
    )
  end

  defp max_pow_of_2(0), do: 0
  defp max_pow_of_2(till) do
    max_pow_of_2(till, -1)
  end
  defp max_pow_of_2(0, pow), do: pow
  defp max_pow_of_2(till, pow), do: max_pow_of_2(till >>> 1, pow+1)

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    list(flags, item) === item
  end
end
