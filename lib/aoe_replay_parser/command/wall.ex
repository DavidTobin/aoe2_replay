defmodule AoeReplayParser.Command.Wall do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<_::bytes-size(1), player_id::little-integer-size(8), x::little-integer-size(8),
          y::little-integer-size(8), _::bits>>
      ) do
    %C{
      type: :wall,
      command: %C.Wall{
        player_id: player_id,
        coords: {x, y}
      }
    }
  end
end
