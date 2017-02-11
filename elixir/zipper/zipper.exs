defmodule BinTree do
  import Inspect.Algebra
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat ["(", to_doc(v, opts),
            ":", (if l, do: to_doc(l, opts), else: ""),
            ":", (if r, do: to_doc(r, opts), else: ""),
            ")"]
  end
end

defmodule Zipper do
  defstruct focus_i: 0, values: %{}
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    q = :queue.new
    vals = bf_vals(:queue.in(bt, q))

    %Zipper{focus_i: 0, values: vals}
  end

  defp bf_vals(q) do
    {root, q} = :queue.out(q)
    q = :queue.in(root, q)

    bf_vals(q, %{0 => root.value}, 0)
  end
  defp bf_vals(q, vals, i) do
    if :queue.is_empty(q) do
      vals
    else
      {node, q} = :queue.out(q)
      l = node.left
      r = node.right
      q = :queue.in(l, q)
      q = :queue.in(r, q)
      vals = Map.put(vals, 2*i+1, l.value)
      |> Map.put(2*i+2, r.value)

      bf_vals(q, vals, i+1)
    end
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(z) do
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(z) do
    z.values[z.focus]
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(z) do
    set_focus(z, z.focus*2+1)
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(z) do
    set_focus(z, z.focus*2+2)
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t | nil
  def up(z) do
    if z.focus > 0, do: set_focus(z, div(z.focus-1, 2))
  end

  defp set_focus(z, i) do
    if z.values[i], do: Map.put(z, :focus, i)
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z, v) do
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z, l) do
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z, r) do
  end
end
