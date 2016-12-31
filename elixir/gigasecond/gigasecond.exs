defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  @gigasec 1000000000
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    y = Float.floor(@gigasec / 364.25) |> Float.floor |> round
    m = (@gigasec / 364.25 - y)*12 |> Kernel.+(1) |> Float.floor |> round
    d = ((@gigasec / 364.25 - y)*12 - m) * days_in(m, y) |> Kernel.+(1) |> Float.floor |> round
    h = rem(1000000000, 24*60*60) / 60 / 60 |> Float.floor |> round
    d = rem(1000000000, 24*60*60) / 60 - h*60 |> Float.floor |> round
    s = 
  end

  defp days_in(m, y) do

  end
end
