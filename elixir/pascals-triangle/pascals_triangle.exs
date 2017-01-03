defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(n) when n<=0, do: :error
  def rows(0), do: []
  def rows(n) do
    
  end
end
