defmodule AoeReplayParser.Command.Game do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command

  def parse(<<mode_id::little-integer-size(8), player_id::little-integer-size(8), _::bits>>) do
    %Command{
      type: :game,
      command: %Command.Game{
        player_id: player_id,
        mode_id: mode_id
      }
    }
  end
end
