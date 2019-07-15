defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    do_numerals(number, "")
  end

  defp do_numerals(number, roman) when number >= 1000 do
    do_numerals(number - 1000, roman <> "M")
  end

  defp do_numerals(number, roman) when number >= 900 do
    do_numerals(number - 900, roman <> "CM")
  end

  defp do_numerals(number, roman) when number >= 500 do
    do_numerals(number - 500, roman <> "D")
  end

  defp do_numerals(number, roman) when number >= 400 do
    do_numerals(number - 400, roman <> "CD")
  end

  defp do_numerals(number, roman) when number >= 100 do
    do_numerals(number - 100, roman <> "C")
  end

  defp do_numerals(number, roman) when number >= 90 do
    do_numerals(number - 90, roman <> "XC")
  end

  defp do_numerals(number, roman) when number >= 50 do
    do_numerals(number - 50, roman <> "L")
  end

  defp do_numerals(number, roman) when number >= 40 do
    do_numerals(number - 40, roman <> "XL")
  end

  defp do_numerals(number, roman) when number >= 10 do
    do_numerals(number - 10, roman <> "X")
  end

  defp do_numerals(number, roman) when number == 9 do
    do_numerals(number - 9, roman <> "IX")
  end

  defp do_numerals(number, roman) when number >= 5 do
    do_numerals(number - 5, roman <> "V")
  end

  defp do_numerals(number, roman) when number == 4 do
    do_numerals(number - 4, roman <> "IV")
  end

  defp do_numerals(number, roman) when number >= 1 do
    do_numerals(number - 1, roman <> "I")
  end

  defp do_numerals(0, roman), do: roman
end
