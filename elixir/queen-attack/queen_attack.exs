defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(w_rc, b_rc) when w_rc === b_rc, do: raise ArgumentError
  def new(w_rc \\ {0, 3}, b_rc \\ {7, 3}) do
    %Queens{ black: b_rc, white: w_rc }
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    Enum.reduce(0..7, [], fn(r, acc) ->
      acc ++ [Enum.reduce(0..7, [], fn(c, acc) ->
        cond do
          queens.black === {r,c} -> ["B" | acc]
          queens.white === {r,c} -> ["W" | acc]
          true -> ["_" | acc]
        end
      end)
      |> Enum.reverse
      |> Enum.join(" ")]
    end)
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do

  end
end
