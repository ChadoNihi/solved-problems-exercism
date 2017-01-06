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
    rs = rows(str)
    till_c = Enum.count( Enum.at(rs, 0) )
    check_point(rs, 0, 0, List.duplicate(false, till_c), [], [], Enum.count(rs), till_c)
  end

  defp check_point(rows, r, c, skip_on_curr_row, skip_on_next_row, spoints, till_r, till_c) do
    cond do
      Enum.at(skip_on_curr_row, c) ->
        check_point(rows, r, c+1, skip_on_curr_row, [false | skip_on_next_row], spoints, till_r, till_c)
      r >= till_r ->
        spoints
      c >= till_c ->
        check_point(rows, r+1, 0, Enum.reverse(skip_on_next_row), [], spoints, till_r, till_c)
      true ->
        curr_val = Enum.at(rows, r) |> Enum.at(c)
        prev_r = max(r-1, 0)
        prev_c = max(c-1, 0)

        valid_row = curr_val >= 2d_at(rows, r, prev_c) and curr_val >= 2d_at(rows, r, c+1)
        valid_col = curr_val <= 2d_at(rows, prev_r, c) and curr_val <= 2d_at(rows, r+1, c)

        if valid_row and valid_col do
          check_point(rows, r, c+1, skip_on_curr_row, [true | skip_on_next_row], [{r,c} | spoints], till_r, till_c)
        else
          check_point(rows, r, c+1, skip_on_curr_row, [false | skip_on_next_row], spoints, till_r, till_c)
        end
    end
  end

  defp 2d_at(arr, r, c), do: Enum.at(arr, r, []) |> Enum.at(arr, c, )
end
