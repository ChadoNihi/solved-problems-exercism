defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    Date.new(year, month, get_date(year, month, weekday, schedule))
    |> Date.to_erl
  end

  defp get_date(year, month, weekday, schedule) do
    fst_month_day = Date.new(year, month, 1)
    |> Date.day_of_week

    fst_month_day 
  end
end
