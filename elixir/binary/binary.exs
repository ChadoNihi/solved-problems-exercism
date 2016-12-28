defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    if String.match?(string, ~r/^[01]+$/) do

      String.graphemes(string)
      |> Enum.map(fn(ch) -> String.to_integer(ch) end)
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.reduce(0, fn({dig, pow}, sum) -> sum + dig*:math.pow(2, pow) end)

    else

      0

    end
  end
end
