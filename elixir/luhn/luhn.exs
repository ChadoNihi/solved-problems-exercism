defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(num_str) do
    String.reverse(num_str)
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({false, []}, fn(dig, {double?, digs}) ->
      if double? do
        {false, (if dig*2 >= 10, do: [dig*2-9 | digs], else: [dig*2 | digs])}
      else
        {true, [dig | digs]}
      end
    end)
    |> elem(1)
    |> Enum.sum
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(num_str) do
    rem(checksum(num_str), 10) === 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(num_str) do
    num_str <> Integer.to_string(rem(10 - rem(checksum(num_str<>"0"), 10), 10))
  end
end
