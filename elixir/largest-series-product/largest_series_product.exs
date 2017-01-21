defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    if size < 0 or String.lenght(number_string) < size or !String.match?(number_string, ~r/^\d*$/) do
      raise ArgumentError
    else
      nums = String.graphemes(number_string)
      |> Enum.map(&String.to_integer/1)

      f(nums, Enum.take(nums, size), size, 0)
    end
  end

  defp f(nums_left, slice, size, max) when , do: max
  defp f(nums_left, slice, size, max) do
    f(tl(nums_left), [hd(nums_left) | tl(slice)], size, max(max, multiply(slice)))
  end
end
