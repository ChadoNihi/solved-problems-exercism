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
    month_fst_weekday = Date.new(year, month, 1)
    |> elem(1)
    |> Date.day_of_week

    weekday_num = weekday_to_num(weekday)
    weekday_fst_date =
      (if weekday_num < month_fst_weekday, do: weekday_num+8, else: weekday_num+1) - month_fst_weekday

    weekday_fst_date + 7*schedule_to_multiplier(schedule, month, month_fst_weekday, weekday_num)
  end

  defp weekday_to_num(weekday) do
    case weekday do
      :monday -> 1
      :tuesday -> 2
      :wednesday -> 3
      :thursday -> 4
      :friday -> 5
      :saturday -> 6
      :sunday -> 7
    end
  end

  defp schedule_to_multiplier(schedule, month, month_fst_weekday, weekday_num) do
    case schedule do
      :first ->
        0
      :second ->
        1
      :third ->
        2
      :fourth ->
        3
      :last ->
        if month  do

        end
      :teenth ->
        diff = month_fst_weekday - weekday_num
        if diff > 0 and diff < 3, do: 1, else: 2
    end
  end
end
