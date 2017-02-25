defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate(board) do
    max_r = Enum.count(board)-1
    max_c = String.length(hd(board))
    brd = Enum.map(board, fn(row_str) ->
      String.graphemes(row_str)
    end)

    Enum.map(0..max_r, fn(r) ->
      Enum.reduce(max_c..0, %{left: , center: , right: 0, acc_row: []}, fn(x, mem) ->
        if x == "*" do
          Map.update!(mem, :acc_row, &([x | &1]))
        else

        end
      end)
    end)
  end
end
