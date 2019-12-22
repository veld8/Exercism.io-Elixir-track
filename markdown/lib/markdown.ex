defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(fn l -> process_line(l) end)
    |> parse_content()
    |> join_list_items()
  end

  defp process_line("#" <> l), do: parse_header(l, 1)
  defp process_line("* " <> l), do: "<li>#{l}</li>"
  defp process_line(l), do: "<p>#{l}</p>"

  defp parse_header(" " <> l, acc), do: "<h#{acc}>#{l}</h#{acc}>"
  defp parse_header("#" <> l, acc), do: parse_header(l, acc + 1)

  defp parse_content(l) do
    l |> parse_bold() |> parse_italic()
  end

  defp parse_bold(l), do: String.replace(l, ~r/__(.*)__/, "<strong>\\g{1}</strong>")
  defp parse_italic(l), do: String.replace(l, ~r/_(.*)_/, "<em>\\g{1}</em>")

  defp join_list_items(s) do
    String.replace(s, ~r/(\<li\>.*\<\/li\>)/, "<ul>\\g{1}</ul>")
  end
end
