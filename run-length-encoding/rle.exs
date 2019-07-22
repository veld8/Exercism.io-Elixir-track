defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""
  def encode(string) do
    string
    |> String.codepoints()
    |> do_encode()
  end

  defp do_encode(string), do: do_encode(string, 0, "")
  defp do_encode([head | tail], 0, "") do
    do_encode(tail, head, 1, "")
  end
  defp do_encode([], last_letter, 1, new_string) do
    new_string <> last_letter
  end
  defp do_encode([], last_letter, count, new_string) do
    letters = Integer.to_string(count) <> last_letter
    new_string <> letters
  end
  defp do_encode([head|tail], last_letter, 1, new_string) do
    case head == last_letter do
      true ->
        do_encode(tail, head, 2, new_string)
      false ->
        do_encode(tail, head, 1, new_string <> last_letter)
    end
  end
  defp do_encode([head|tail], last_letter, count, new_string) do
    case head == last_letter do
      true ->
        do_encode(tail, head, count + 1, new_string)
      false ->
        letters = Integer.to_string(count) <> last_letter
        do_encode(tail, head, 1, new_string <> letters)
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(""), do: ""
  def decode(string) do
    Regex.scan(~r/[1-9]*[A-Z|a-z|\s]/, string)
    |> List.flatten()
    |> do_decode()
  end

  defp do_decode(string) do
    Enum.reduce(string, "", fn x, acc ->
      acc <> accum_letters(x)
    end)
  end

  defp accum_letters(<<letter::binary-size(1)>>), do: to_string(letter)
  defp accum_letters(string) do
    length = String.length(string)
    letter = String.last(string)

    string
    |> String.slice(0, length - 1)
    |> to_int()
    |> do_accum(letter)
  end

  defp do_accum(count, letter), do: do_accum(count, letter, "")
  defp do_accum(1, letter, string), do: string <> letter
  defp do_accum(count, letter, string) do
    do_accum(count - 1, letter, string <> letter)
  end

  defp to_int(string) do
    {int, _rest} = Integer.parse(string)
    int
  end
end
