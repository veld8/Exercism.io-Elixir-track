defmodule Phone do
  @bad_number "0000000000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    raw
    |> remove_decorations()
    |> replace_letters()
    |> do_number()
  end

  defp remove_decorations(raw), do: String.replace(raw, ~r/[\(\)\-\+\,\.\s]/, "")
  defp replace_letters(raw), do: String.replace(raw, ~r/\b.*\D.*\b/, @bad_number)

  defp do_number(<<"1", number::binary-10>>), do: number
  defp do_number(<<first::binary-1>> <> _rest) when first == "1" or first == "0", do: @bad_number
  defp do_number(<<_area::binary-3>> <> "1" <> _rest), do: @bad_number
  defp do_number(<<_area::binary-3>> <> "0" <> _rest), do: @bad_number
  defp do_number(<<number::binary-10>>), do: number
  defp do_number(_), do: @bad_number

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw
    |> number()
    |> String.slice(0..2)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    raw |> number() |> do_pretty()
  end

  defp do_pretty(raw) do
    <<area::binary-3, exchange::binary-3, subscriber::binary-4>> = raw
    "(#{area}) #{exchange}-#{subscriber}"
  end
end
