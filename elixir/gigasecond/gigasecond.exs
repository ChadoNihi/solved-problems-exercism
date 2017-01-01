defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  @gigasec 1000000000
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    #OK, I got it:
    # given datetime to unix |> + gigasec |> to date
    

  #   y = @gigasec / (365.25*24*60*60) |> Float.floor |> round
  #   m = (@gigasec / (365.25*24*60*60) - y)*12 |> Kernel.+(1) |> Float.floor |> round
  #   d = ((@gigasec / (365.25*24*60*60) - y)*12 - m) * days_in(m, y) |> Kernel.+(1) |> Float.floor |> round
  #   h = rem(1000000000, 24*60*60) / 60 / 60 |> Float.floor |> round
  #   min = rem(1000000000, 24*60*60) / 60 - h*60 |> Float.floor |> round
  #   s = rem(1000000000, 24*60*60) - h*60*60 - min*60
  #
  #   if seconds+s >= 60
  #
  #   {{y, m, d}, {h, min, s}}
  # end
  #
  # defp days_in(m, _) when m in [1,3,5,7,8,10,12], do: 31
  # defp days_in(m, _) when m in [4,6,9,11], do: 30
  # defp days_in(m, y) do
  #   if leap_year?(y), do: 29, else: 28
  # end
  #
  # defp leap_year?(y) do
  #   rem(y, 4) === 0 && (rem(y, 100) !== 0 || rem(y, 400) === 0)
  # end
end
