defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  @gigasec 1000000000
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    @gigasec / 365
  end
end
