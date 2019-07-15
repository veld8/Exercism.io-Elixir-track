defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r"[\!\&\@\%\&\^\$\:\,\.]", "")
    |> String.replace(~r"[\_]", " ")
    |> String.split()
    |> do_count(%{})
  end

  defp do_count([], map), do: map
  defp do_count(string, map) do
    Enum.reduce(string, map, &increase_count/2)
  end

  defp increase_count(string, map) do
    Map.update(map, string, 1, fn value ->
      value + 1
    end)
  end
end
