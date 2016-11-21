defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @error_str "0000000000"

  @spec number(String.t) :: String.t
  def number(raw) do
    if String.length(raw) < 10 do
      @error_str
    else
      num_str = (String.graphemes(raw)
      |> Enum.reduce_while("", &(number_step &1, &2)))

      cond do
        String.length(num_str) == 10 ->
          num_str
        String.length(num_str) == 11 and
        String.first(num_str) == "1" ->
          String.slice(num_str, 1, 10)
        true ->
          @error_str
      end
    end

  end

  defp number_step(ch, acc) do
    cond do
      String.match?(ch, ~r/[a-z]/i) ->
        {:halt, @error_str}
      String.match?(ch, ~r/\d/) ->
        {:cont, acc<>ch}
      true ->
        {:cont, acc}
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    number(raw)
    |> String.slice(0,3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    num_str = number(raw)
    offset = if String.length(raw)==11, do: 1, else: 0
    "(#{String.slice(raw,0+offset,3)}) #{String.slice(raw,3+offset,3)}-#{String.slice(raw,6+offset,4)}"
  end
end
