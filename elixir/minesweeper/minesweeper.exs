defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate(board) do
    max_r = Enum.count(board)-1
    max_c = String.length(hd(board))
    brd = Enum.reduce(board, {0, %{}}, fn(row_str, {r, row}) ->
      {
        r+1,
        Map.put(row, r,
          String.graphemes(row_str)
          |> Enum.reduce({0, %{}}, fn(cell, {c, }) -> ... end)
          |> elem(1)
        )
      }
    end)
    |> elem(1)

    Enum.map(0..max_r, fn(r) ->
      Enum.reduce(max_c..0, %{center: count_col(brd, r, max_c), right: 0, acc_row: []}, fn(x, mem) ->
        left = count_col(brd, r, c-1)

        Map.put(mem, :right, mem.center)
        |> Map.put(:center, left)
        |> Map.update!(:acc_row,
          &([(if x == "*", do: x, else: left+mem.center+mem.right) | &1])
        )
      end)
      |> Map.get(:acc_row)
    end)
  end

  defp count_col(brd, r, c) do
    (if brd[r][c-1] == "*", do: 1, else: 0)
    + (if brd[r][c] == "*", do: 1, else: 0)
    + (if brd[r][c+1] == "*", do: 1, else: 0)
  end
end
