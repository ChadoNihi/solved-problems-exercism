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
  def reverse(l), do: do_reverse(list, [])

  defp do_reverse([], acc), do: acc
  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h | t], f) do
    [f.(h) | map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([h | t], f) do
    if f.(h) do
      [h | filter(t, f)]
    else
      filter(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, []), do: a
  def append(a, [h2 | t2]) do
    #[a | [h2 | append()]]
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do

  end
end
