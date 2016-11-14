defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    String.graphemes(str)
    |> Enum.reduce_while([], step)
  end

  defp step(ch, stack) do
    cond do
      ch == "[" or ch == "(" or ch == "{" ->
        {:cont, stack ++ [ch]}
      ch == "]" and Enum.at(stack, Enum.count(stack)-1) == "[" ->
        {:cont, Enum.drop(stack, -1)}
    end
  end
end
