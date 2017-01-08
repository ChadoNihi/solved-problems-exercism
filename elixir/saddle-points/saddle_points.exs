defmodule Matrix do
  @max 99999999
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
    check_point(rs, columns(str), 0, 0, %{}, [], Enum.count(rs), till_c)
    |> Enum.reverse
  end

  defp check_point(rows, cols, r, c, to_skip, spoints, till_r, till_c) do
    cond do
      Map.has_key?(to_skip, {r,c}) ->
        check_point(rows, cols, r, c+1, to_skip, spoints, till_r, till_c)
      r >= till_r ->
        spoints
      c >= till_c ->
        check_point(rows, cols, r+1, 0, to_skip, spoints, till_r, till_c)
      true ->
        row = Enum.at(rows, r)
        col = Enum.at(cols, c)
        curr_val = Enum.at(row, c)

        valid_row = Enum.all?(row, &(&1<=curr_val))
        valid_col = Enum.all?(col, &(&1>=curr_val))

        if valid_row and valid_col do
          check_point(rows, cols, r+1, 0, update_to_skip(to_skip, rows, curr_val, r, c, till_r-1), [{r,c} | spoints], till_r, till_c)
        else
          check_point(rows, cols, r, c+1, to_skip, spoints, till_r, till_c)
        end
    end
  end

  defp update_to_skip(to_skip, rows, curr_val, r, c, max_r) do
    Enum.reduce((r+1)..max_r, to_skip, fn(r, to_skip) ->
      if curr_val > Enum.at(rows, r, []) |> Enum.at(c, @max) do
        Map.put(to_skip, {r,c}, true)
      else
        to_skip
      end
    end)
  end
end
