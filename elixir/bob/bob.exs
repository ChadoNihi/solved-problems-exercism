defmodule Bob do
  def hey(input) do
    cond do
        String.match?(input, ~r/^\s*$/) -> "Fine. Be that way!"
        String.ends_with?(input, "?") -> "Sure."
        String.match?(input, ~r/^[ A-ZА-Я]+!?$/)
          or (String.upcase(input) == input and String.ends_with?(input, "!")) -> "Whoa, chill out!"
        true -> "Whatever."
    end
  end
end
