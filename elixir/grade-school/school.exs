defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    Map.update(db, grade, [name], fn(names) -> names ++ [name] end)
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    Map.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    Enum.map(db, fn {grade, names} -> {grade, Enum.sort(names)} end)
    |> Enum.sort(fn {grade1, _}, {grade2, _} -> grade1<=grade2 end)
  end
end
