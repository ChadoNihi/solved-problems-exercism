defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @letters String.graphemes("abcdefghijklmnopqrstuvwxyz")
  @cipher String.graphemes("zyxwvutsrqponmlkjihgfedcba")
  @letter_to_cipher Enum.zip(@letters, @cipher) |> Map.new

  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    String.downcase(plaintext)
    |> String.replace(~r/[!.,?_@#$%^&*()+=-]|\s/, "")
    |> String.graphemes
    |> Enum.map(&(@letter_to_cipher[&1] || &1))
    |> Enum.chunk(5, 5, [])
    |> Enum.map(fn(letter_group) -> Enum.join(letter_group) end)
    |> Enum.join(" ")
  end
end
