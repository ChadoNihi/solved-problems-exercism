defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(1), do: """
  No more bottles of beer on the wall, no more bottles of beer.
  Go to the store and buy some more, 99 bottles of beer on the wall.
  """
  def verse(2), do: """
  1 bottle of beer on the wall, 1 bottle of beer.
  Take it down and pass it around, no more bottles of beer on the wall.
  """
  def verse(number) do
    """
    #{number-1} bottles of beer on the wall, #{number-1} bottles of beer.
    Take one down and pass it around, #{number-2} bottle#{if number>3, do: "s"} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics() do
    lyrics 100..1
  end
  def lyrics(range) do
    Enum.reduce(range, [], fn(n, acc) -> acc ++ [verse(n)] end)
    |> Enum.join("\n")
  end
end
