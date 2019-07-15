defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    convert(dna, [])
  end

  defp convert([], rna), do: rna
  defp convert([71 | dna], rna), do: convert(dna, rna ++ 'C')
  defp convert([67 | dna], rna), do: convert(dna, rna ++ 'G')
  defp convert([84 | dna], rna), do: convert(dna, rna ++ 'A')
  defp convert([65 | dna], rna), do: convert(dna, rna ++ 'U')
end
