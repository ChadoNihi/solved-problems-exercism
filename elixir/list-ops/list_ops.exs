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
  def reverse(l) do
    if count(l) <= 1000 do
      reverse_rec(l)
    else
      reverse_iter(l)
    end
  end
  defp reverse_rec([]), do: []
  defp reverse_rec([h | t]) do
    reverse_rec(t) ++ [h]
  end

  defp reverse_iter(l) do
    last_i = Enu.count(l)-1
    Range.new(0, last_i)
    |> Enum.reduce([], fn(i, acc) -> acc++[Enum.at(l, last_i-i)] end)
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
