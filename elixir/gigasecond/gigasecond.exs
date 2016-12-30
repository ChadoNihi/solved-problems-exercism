defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  @gigasec 1000000000
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    y = Float.floor(@gigasec / 364.25) |> round
    m = (@gigasec / 364.25 - y)*12 |> Float.floor |> &+.(1) |> round
    d = ((@gigasec / 364.25 - y)*12 - m) * days_in(m, y)
  end

  defp days_in(m, y) do
    
  end
end
