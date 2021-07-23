defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @lowercase ?a..?z
  @uppercase ?A..?Z

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when shift >= 26, do: (rotate(text, shift - 26))
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&(do_rotate(&1, shift)))
    |> to_string
  end

  defp do_rotate(char, shift) do
    cond do
      char in @lowercase -> rem(char - ?a + shift, 26) + ?a
      char in @uppercase -> rem(char - ?A + shift, 26) + ?A
      true -> char
    end
  end
end
