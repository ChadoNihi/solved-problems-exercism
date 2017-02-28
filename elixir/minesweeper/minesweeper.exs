defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate([]), do: []
  def annotate(board) do
    max_r = Enum.count(board)-1
    max_c = String.length(hd(board))-1
    brd = Enum.reduce(board, {0, %{}}, fn(row_str, {r, brd}) ->
      {
        r+1,
        Map.put(brd, r,
          String.graphemes(row_str)
          |> Enum.reduce({0, %{}}, fn(cell, {c, row}) -> {c+1, Map.put(row, c, cell)} end)
          |> elem(1)
        )
      }
    end)
    |> elem(1)
    |> IO.inspect

    Enum.map(0..max_r, fn(r) ->
      Enum.reduce(max_c..0, %{center: count_col(brd, r, max_c), right: 0, acc_row: []}, fn(c, mem) ->
        left = count_col(brd, r, c-1)
        Map.update!(mem, :acc_row,
          &([
            (if brd[r][c] == "*" do
              "*"
            else
              cnt = left+mem.center+mem.right
              if cnt == 0, do: " ", else: cnt
            end) | &1])
        )
        |> Map.put(:right, mem.center)
        |> Map.put(:center, left)
      end)
      |> Map.get(:acc_row)
      |> Enum.join()
    end)
  end

  defp count_col(brd, r, c) do
    (if brd[r-1][c] == "*", do: 1, else: 0) +
    (if brd[r][c] == "*", do: 1, else: 0) +
    (if brd[r+1][c] == "*", do: 1, else: 0)
  end
end
