defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([_|t]), do: 1 + count(t)
  def count([]), do: 0

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([h|t], acc), do: reverse(t, [h|acc])
  def reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    for i <- l, do: f.(i)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    for i <- l, f.(i), do: i
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([h|t], acc, f), do: reduce(t, f.(h, acc), f)
  def reduce([], acc, _), do: acc

  @spec append(list, list) :: list
  def append([h|t], b), do: [h|append(t,b)]
  def append([], b), do: b

  @spec concat([[any]]) :: [any]
  def concat([h|t]), do: append(h, concat(t))
  def concat([]), do: []
end
