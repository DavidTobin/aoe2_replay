defmodule AoeReplayParser.Command.Resign do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(<<player_id::little-integer-size(8), _::bits>>) do
    %C{
      type: :resign,
      command: %C.Resign{
        player_id: player_id
      }
    }
  end
end
