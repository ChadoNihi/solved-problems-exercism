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
    if string == "" do
      ""
    else
      chars = String.graphemes string

      Enum.with_index(chars)
      |> Enum.reduce(%{localCnt: 1, res: ""}, fn(chIndexTup, acc) -> encode_step(chIndexTup, acc, chars) end)
      |> Map.get(:res)
    end
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

  defp encode_step(chIndexTup, acc, chars) do
    if elem(chIndexTup, 0) == Enum.at(chars, elem(chIndexTup, 1)+1) do
      Map.update!(acc, :localCnt, &(&1 + 1))
    else
      Map.update!(acc,
        :res,
        fn res -> Enum.join(
          [
            res,
            Map.get(acc, :localCnt),
            elem(chIndexTup, 0)
          ])
        end
      ) |> Map.update!(:localCnt, fn _ -> 1 end)
    end
  end
end
