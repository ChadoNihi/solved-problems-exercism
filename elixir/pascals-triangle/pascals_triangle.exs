defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(n) when n<=0, do: :error
  def rows(0), do: []
  def rows(1), do: [[1]]
  def rows(2), do: [[1], [1,1]]
  def rows(n) do
    Enum.reduce(3..n, [[1,1], [1]], fn(r, [h | _t] = acc) ->
      [make_row(h, r) | acc]
    end)
    |> Enum.reverse
  end

  defp make_row(prev_r, curr_r_num) do
    Enum.reduce(1..(curr_r_num-2), [1], fn(i, acc) -> [Enum.at(prev_r, i)+Enum.at(prev_r, i-1) | acc] end)
    |> Enum.reverse
    |> Kernel.++ [1]
  end
end
