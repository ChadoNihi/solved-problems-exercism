defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    nums = Regex.scan(~r/(-?\d+)/i, question)
    |> Enum.map(fn([_, cptr]) -> String.to_integer(cptr) end)

    ops = Regex.scan(~r/(plus|minus|multipl|divid|power)/i, question)
    |> Enum.map(fn([_, cptr]) -> to_op(cptr) end)

    cond do
      Enum.empty?(nums) or Enum.empty?(ops) ->
        raise ArgumentError
      hd(ops) == "pow" or Enum.at(ops, 1) == "pow" ->
        res = :math.pow(hd(nums), (if hd(ops) == "-", do: -(Enum.at(nums, 1)), else: Enum.at(nums, 1)))
        if res >= 1 or res === 0.0, do: round(res), else: res
      true ->
        Enum.reduce(tl(nums) |> Enum.zip(ops), hd(nums), fn({right_num, op}, acc) ->
          apply(Kernel, String.to_existing_atom(op), [acc, right_num])
        end)
        |> round
    end
  end

  defp to_op(str) do
    case str do
      "plus" -> "+"
      "minus" -> "-"
      "multipl" -> "*"
      "divid" -> "/"
      "power" -> "pow"
    end
  end
end
