defmodule Triplet do

  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet) do
    Enum.sum(triplet)
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
    Enum.reduce(triplet, &(&1*&2))
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
    a*a + b*b === c*c
  end

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max) do
    generate(min, max, false)
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, _) when min > max, do: []
  def generate(min, max, sum) do
    Enum.reduce(max..min, [], fn(x, all_triplets) ->
      xx = x*x
      y = x+1
      z = y+1

      triplets = triplet_step(x, y, z, xx, max, sum)
      |> Enum.reverse

      if Enum.empty?(triplets), do: all_triplets, else: [triplets | all_triplets]
    end)
    |> List.flatten
    |> Enum.chunk(3,3,[])
  end

  defp triplet_step(x, y, z, xx, max, sum) do
    triplet_step(x, y, z, xx, max, sum, [])
  end
  defp triplet_step(_x, _y, z, _xx, max, _sum, triplets) when z > max, do: triplets
  defp triplet_step(x, y, z, xx, max, sum, triplets) do
    zz = xx + y*y
    new_z = iterate_z(z, zz)

    triplet_step(x,y+1,new_z,xx,max,sum,
      (if new_z*new_z == zz and new_z <= max and (!is_number(sum) or sum([x,y,new_z])==sum), do: [[x,y,new_z] | triplets], else: triplets)
    )
  end

  defp iterate_z(z, zz) when z*z >= zz, do: z
  defp iterate_z(z, zz), do: iterate_z(z+1, zz)
end
