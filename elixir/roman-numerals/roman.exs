defmodule Roman do
  @max_num 3999
  @doc """
  Convert the number to a roman number. (By the convention the function name should end with !, since it raises.)
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) when number <= 0 or number > @max_num, do: raise "Must be an integer in 1-#{@max_num}."
  def numerals(number) do
    Integer.to_string(number)
    |> String.graphemes
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reverse
    |> Enum.reduce("", fn(digchar_tier_tup, acc) -> acc <> rom_step(digchar_tier_tup) end)
  end

  defp rom_step({digchar, tier}) do
    to_rom_simple(:math.pow(10,tier) |> round, String.to_integer(digchar))
  end

  defp to_rom_simple(base, ntimes) do
    cond do
      ntimes < 4 -> to_rom_ntimes(base, ntimes)
      ntimes < 6 -> to_rom_ntimes(base, 5-ntimes) <> to_rom(base*5)
      ntimes < 9 -> to_rom(base*5) <> to_rom_ntimes(base, ntimes-5)
      ntimes < 11 -> to_rom_ntimes(base, 10-ntimes) <> to_rom(base*10)
    end
  end

  defp to_rom_ntimes(_, 0), do: ""
  defp to_rom_ntimes(base, n) do
    to_rom(base) <> to_rom_ntimes(base, n-1)
  end

  defp to_rom(num) do
    case num do
      1 -> "I"
      5 -> "V"
      10 -> "X"
      50 -> "L"
      100 -> "C"
      500 -> "D"
      1000 -> "M"
    end
  end
end
