defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""
  def encode(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[\s\.\,\!\`\']/, "")
    |> String.codepoints()
    |> create_rectangle()
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.join(" ")
  end

  defp create_rectangle(str) do
    col = calculate_columns(str)
    Enum.chunk_every(str, col, col, Stream.cycle([""]))
  end

  defp calculate_columns(str) do
    length(str) |> :math.sqrt() |> Float.ceil |> trunc()
  end
end
