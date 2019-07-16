defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number
    |> Integer.digits()
    |> Enum.reduce(0, fn x, acc -> :math.pow(x, integer_length(number)) + acc end)
    |> Kernel.==(number)
  end

  defp integer_length(number) do
    number
    |> Integer.digits()
    |> length()
  end
end
