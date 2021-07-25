defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, [_ | []] = file), do: do_grep(pattern, flags, file)
  def grep(pattern, flags, files), do: do_grep(pattern, flags ++ ["-m"], files)

  def do_grep(pattern, flags, files) do
    files
    |> read_files()
    |> Enum.filter(fn {_, _, line} -> filter(line, pattern, flags) end)
    |> Enum.map(fn {filename, number, line} -> print_line(filename, number, line, flags) end)
    |> Enum.uniq()
    |> List.to_string()
  end

  defp read_files(files) do
    for f <- files, {s, i} <- File.stream!(f) |> Stream.with_index() |> Enum.to_list() do
      {"#{f}", "#{i + 1}", "#{s}"}
    end
  end

  defp filter(line, pattern, flags) do
    cond do
      "-i" in flags -> String.contains?(String.upcase(line), String.upcase(pattern))
      "-x" in flags -> line == pattern <> "\n"
      "-v" in flags -> !String.contains?(line, pattern)
      true -> String.contains?(line, pattern)
    end
  end

  def print_line(filename, number, line, flags) do
    cond do
      "-l" in flags -> "#{filename}\n"
      "-n" in flags && "-m" in flags -> "#{filename}:#{number}:#{line}"
      "-n" in flags -> "#{number}:#{line}"
      "-m" in flags -> "#{filename}:#{line}"
      true -> "#{line}"
    end
  end
end
