defmodule AoeReplayParser.Header do
  require Logger

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.GameDetails
  alias __MODULE__.{Version, Dlc, Players, Guid}

  def parse(header) do
    with {game, rest} <- Version.parse(header, %GameDetails{}),
         {game, rest} <- Dlc.parse(rest, game),
         {game, rest} <- Players.parse(rest, game),
         {game, _} <- Guid.parse(rest, game) do
      game
    else
      _ -> :error
    end
  end

  def parse(_, data), do: data
end
