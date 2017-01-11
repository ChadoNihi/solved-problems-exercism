defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(nums, num) do
    search(nums, num, 0, tuple_size(nums)-1)
  end
  def search(_nums, _num, min_i, max_i) when min_i > max_i, do: :not_found
  def search(nums, num, min_i, max_i) do

  end
end
