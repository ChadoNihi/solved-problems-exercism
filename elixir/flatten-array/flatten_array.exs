defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    list_str = inspect(list, charlists: :as_lists)
    Regex.scan(~r/(\d+)/, list_str)
    |> Enum.reduce([], fn(x, acc) -> [String.to_integer(Enum.at(x, 1)) | acc] end)
    |> Enum.reverse
  end
end
