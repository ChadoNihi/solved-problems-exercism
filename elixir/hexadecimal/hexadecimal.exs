defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    if String.match?(hex, ~r/^[0-9a-f]+$/i) do
      String.graphemes(hex)
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.reduce(0, fn({ch, i}, sum) -> sum + ch_to_num!(ch)*:math.pow(16, i) end)
    else
      0
    end
  end

  defp ch_to_num!(ch) do
    if String.match?(ch, ~r/^\d$/) do
      String.to_integer(ch)
    else
      case String.downcase(ch) do
        "a" ->
          10
        "b" ->
          11
        "c" ->
          12
        "d" ->
          13
        "e" ->
          14
        "f" ->
          15
        true ->
          raise ArgumentError
      end
    end
  end
end
