defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _workers), do: %{}
  def frequency([<<letter::binary-size(1)>>], _workers), do: %{letter => 1}
  def frequency(texts, workers) do
    Task.async_stream(texts, &letter_count/1, max_concurrency: workers)
    |> Enum.reduce(%{}, fn {:ok, map}, acc -> Map.merge(acc, map, fn _k, v1, v2 -> v1 + v2 end) end)
  end

  defp letter_count(text) do
    String.graphemes(text)
    |> Enum.filter(&String.match?(&1, ~r/\p{L}/))
    |> Enum.map(&String.downcase/1)
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 +1)) end)
  end
end
