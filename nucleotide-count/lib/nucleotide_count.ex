defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    strand
    |> Enum.filter(fn x -> x == nucleotide end)
    |> Enum.count()
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand), do: histogram(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0})

  def histogram([], map) do
    map
  end

  def histogram([head | tail], map) do
    nucleotide = Map.fetch!(map, head)
    map = Map.put(map, head, nucleotide + 1)
    histogram(tail, map)
  end
end
