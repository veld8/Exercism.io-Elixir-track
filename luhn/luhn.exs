defmodule Luhn do
  require Integer
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number =
      number
      |> String.replace(" ", "")
      |> String.reverse()

    case valid_length?(number) && valid_format?(number) do
      true ->
        luhn?(number)
      false ->
        false
    end
  end

  defp valid_length?(number) do
    String.length(number) > 1
  end

  defp valid_format?(number) do
    String.match?(number, ~r/^[\d]+$/)
  end

  defp luhn?(number) do
    number
    |> to_int_list()
    |> double_second_digits()
    |> Enum.sum()
    |> divisible_by_ten?()
  end

  defp to_int_list(string) do
    string
    |> String.codepoints()
    |> Enum.map(fn x -> to_int(x) end)
  end

  defp to_int(string) do
    {int, _rest} = Integer.parse(string)
    int
  end

  defp double_second_digits(list) do
    list
    |> Enum.with_index
    |> Enum.map(fn {int, index} ->
      case Integer.is_odd(index) do
        true ->
          stay_below_nine(int * 2)
        false ->
          int
      end
    end)
  end

  defp stay_below_nine(integer) when integer < 10, do: integer
  defp stay_below_nine(integer), do: (integer - 9)

  defp divisible_by_ten?(false), do: false
  defp divisible_by_ten?(integer) when rem(integer, 10) == 0, do: true
  defp divisible_by_ten?(_integer), do: false
end
