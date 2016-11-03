defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, ~r{\s|[a-z](?=[A-Z])|-|,\s}, trim: true)
      |> Enum.map(fn w -> String.upcase(String.at w, 0) end)
      |> Enum.join
  end
end
