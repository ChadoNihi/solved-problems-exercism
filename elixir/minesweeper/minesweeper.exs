defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate(board) do
    Enum.map(board, fn(row_str) ->
      String.graphemes(row_str)
    end)
    |> Enum.map(fn(row) ->
      Enum.reduce(row, %{prev: 0, curr: , next: , acc_row: []}, fn(x, mem) ->

      end)
    end)
  end
end
