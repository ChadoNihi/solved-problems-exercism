defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @names [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]
  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @names) do
    rows_by_two = String.split(info_string, "\n")
    |> Enum.map(fn(row_str) -> String.split(row_str, "") |> Enum.chunk(2) end)

    ll_by_4_plants = Enum.zip(Enum.at(rows_by_two, 0), Enum.at(rows_by_two, 1))
    |> Enum.map(fn({two_plants1, two_plants2}) -> two_plants1 ++ two_plants2 end)

    Enum.sort(student_names)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({name, i}, acc) ->
      Map.put(acc, name, (Enum.at(ll_by_4_plants, i, [])
        |> Enum.reduce({}, &(Tuple.append(&2, letter_to_plant(&1)))))
      )
    end)
  end

  defp letter_to_plant(ch) do
    case ch do
      "C" -> :clover
      "G" -> :grass
      "R" -> :radishes
      "V" -> :violets
    end
  end
end
