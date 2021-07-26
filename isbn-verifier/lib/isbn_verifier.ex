defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    with string <- String.replace(isbn, "-", ""),
         10 <- String.length(string),
         true <- String.match?(string, ~r/(^\d{9}(\d|X)$)/) do
      string
      |> String.graphemes()
      |> Enum.zip(10..1)
      |> Enum.map(&checksum/1)
      |> Enum.sum()
      |> Integer.mod(11) == 0
    else
      _ -> false
    end
  end

  defp checksum({"X", 1}), do: 10

  defp checksum({number, weight}) do
    String.to_integer(number) * weight
  end
end
