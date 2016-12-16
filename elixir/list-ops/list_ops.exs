defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  defp count([], cnt), do: cnt
  defp count([hd | tl], cnt), do: count(tl, cnt+1)
  def count(l) do
    count(l, 0)
  end

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse([h | t]) when count(t) < 1000 do
    reverse(t) ++ [h]
  end
  def reverse(l) do
    
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do

  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do

  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do

  end

  @spec append(list, list) :: list
  def append(a, b) do

  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do

  end
end
