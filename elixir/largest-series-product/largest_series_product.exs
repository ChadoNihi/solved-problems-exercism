defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(number_string, size) do
    if size < 0 or String.length(number_string) < size or !String.match?(number_string, ~r/^\d*$/) do
      raise ArgumentError
    else
      nums = String.graphemes(number_string)
      |> Enum.map(&String.to_integer/1)

      f(nums, size, 0)
    end
  end

  defp f(nums_left, size, max) when length(nums_left) < size, do: max
  defp f(nums_left, size, max) do
    f(tl(nums_left), size, max(max, multiply_first(nums_left, size)))
  end

  defp multiply_first(nums, size) do
    Enum.reduce_while(nums, {1, 0}, fn(x, {prod, i}=acc) ->
      if i >= size do
        {:halt, acc}
      else
        {:cont, {x*prod, i+1}}
      end
    end)
    |> elem(0)
  end
end
