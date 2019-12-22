defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @data %{
    "Allegoric Alaskans" => %{
      wins: 0,
      draws: 0,
      losses: 0
    },
    "Blithering Badgers" => %{
      wins: 0,
      draws: 0,
      losses: 0
    },
    "Courageous Californians" => %{
      wins: 0,
      draws: 0,
      losses: 0
    },
    "Devastating Donkeys" => %{
      wins: 0,
      draws: 0,
      losses: 0
    }
  }

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.reduce(@data, fn r, acc -> parse_result(String.split(r, ";"), acc) end)
    |> Enum.map(fn r -> calculate_points(r) end)
    |> Enum.sort_by(&(elem(&1, 1) |> Map.fetch(:points)), &>=/2)
    |> convert_to_strings()
    |> print_lines()
  end

  defp parse_result([team1, team2, "win"], data) do
    data = update_in(data[team1][:wins], &(&1 + 1))
    update_in(data[team2][:losses], &(&1 + 1))
  end
  defp parse_result([team1, team2, "loss"], data) do
    data = update_in(data[team2][:wins], &(&1 + 1))
    update_in(data[team1][:losses], &(&1 + 1))
  end
  defp parse_result([team1, team2, "draw"], data) do
    data = update_in(data[team1][:draws], &(&1 + 1))
    update_in(data[team2][:draws], &(&1 + 1))
  end
  defp parse_result(_, data), do: data

  defp calculate_points({team, %{wins: wins, losses: losses, draws: draws} = r}) do
    games_played = wins + losses + draws
    points = (wins*3) + draws

    r = r
    |> Map.put(:games_played, games_played)
    |> Map.put(:points, points)
    {team, r}
  end

  defp convert_to_strings(data) do
    for r <- data do
      {team, %{wins: wins, losses: losses, draws: draws, points: points, games_played: games_played}} = r

      if games_played >= 1 do
        team_length = String.length(team)
        spaces = String.duplicate(" ", 31 - team_length)

        "#{team <> spaces}|  #{games_played} |  #{wins} |  #{draws} |  #{losses} |  #{points}\n"
      else
        ""
      end
    end
  end

  defp print_lines(strings) do
    "Team                           | MP |  W |  D |  L |  P\n" <> Enum.join(strings) |> String.trim()
  end
end
