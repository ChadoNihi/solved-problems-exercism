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
    {{_, root}, q} = :queue.out(q)
    q = :queue.in(root, q)

    bf_vals(q, %{0 => root.value}, 0)
  end
  defp bf_vals(q, vals, i) do
    if :queue.is_empty(q) do
      vals
    else
      {{_, node}, q} = :queue.out(q)
      {q, vals} = if node do
        l = node.left
        r = node.right
        q = :queue.in(l, q)
        q = :queue.in(r, q)
        vals = Map.put(vals, 2*i+1, (if l, do: l.value, else: nil))
        |> Map.put(2*i+2, (if r, do: r.value, else: nil))
        {q, vals}
      else
        {q, vals}
      end

      bf_vals(q, vals, i+1)
    end
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(z) do
    to_tree_recur(  (if z.focus_i != 0, do: set_focus(z, 0), else: z)  )
  end

  defp to_tree_recur(z) do
    val = value(z)
    unless value(z) do
      nil
    else
      %BinTree{ value: val, left: to_tree_recur(left(z)), right: to_tree_recur(right(z)) }
    end
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(z) do
    z && z.values[z.focus_i]
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(z) do
    set_focus(z, z.focus_i*2+1)
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(z) do
    set_focus(z, z.focus_i*2+2)
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t | nil
  def up(z) do
    if z.focus_i > 0, do: set_focus(z, div(z.focus_i-1, 2))
  end

  defp set_focus(z, i) do
    if z.values[i] || i === 0, do: Map.put(z, :focus_i, i)
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z, v) do
    Map.put(z, :values, Map.put(z.values, z.focus_i, v))
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z, l) do
    Map.put(z, :values, Map.put(z.values, z.focus_i*2+1, (if l, do: l.value)))
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z, r) do
    set_right(z, r, z.focus_i)
    #Map.put(z, :values, Map.put(z.values, z.focus_i*2+2, (if r, do: r.value)))
  end
  def set_right() when , do:
  def set_right(z, r, i) do
    Map.put(z, :values, Map.put(z.values, i*2+2, r.value))

  end
end
