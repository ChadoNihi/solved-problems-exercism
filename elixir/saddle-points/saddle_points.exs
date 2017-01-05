defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    String.split(str, "\n")
    |> Enum.map(fn(row_str) ->
      String.split(row_str, " ") |> Enum.map(&(String.to_integer(&1)))
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    rows(str)
    |> List.zip
    |> Enum.map(&(Tuple.to_list(&1)))
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    check_point(row(str), 0, 0)


    rows(str)
    |> Enum.reduce([], fn(row, ) -> ... end)
    # to_check = Enum.map(matrix, fn(r) -> Enum.map(r, fn(_x) -> true end) end)
  end
end
