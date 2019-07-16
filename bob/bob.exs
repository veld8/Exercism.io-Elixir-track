defmodule Bob do
  def hey(input) do
    cond do
      is_silent?(input) ->
        "Fine. Be that way!"
      is_yelling?(input) && is_question?(input) ->
        "Calm down, I know what I'm doing!"
      is_question?(input) ->
        "Sure."
      is_yelling?(input) ->
        "Whoa, chill out!"
      is_anything_else?() ->
        "Whatever."
    end
  end

  defp is_silent?(input) do
    String.trim(input) == ""
  end

  defp is_question?(input) do
    String.last(input) == "?"
  end

  defp is_yelling?(input) do
    input == String.upcase(input) && Regex.match?(~r/\p{L}/, input)
  end

  defp is_anything_else? do
    true
  end
end
