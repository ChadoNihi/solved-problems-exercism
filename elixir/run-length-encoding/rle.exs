defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    42
    #Enum.with_index()
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.split(~r/\d+/, string, include_captures: true, trim: true)
    |> Enum.reduce(%{repN: 0, res: ""},
                  fn x, acc -> if String.match?(x, ~r/[1-9]\d*/),
                    do: Map.put(acc, :repN, String.to_integer(x)),
                  else: Map.put(acc, :res,
                                Map.get(acc, :res) <> String.duplicate(x, Map.get(acc, :repN))) end)
    |> Map.get(:res)
  end
end
