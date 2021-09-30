defmodule AoeReplayParser.Command.Build do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<_::bytes-size(1), player_id::little-signed-integer-size(16), x::little-float-size(32),
          y::little-float-size(32), building_id::little-integer-size(32), _::bits>>
      ) do
    %C{
      type: :build,
      command: %C.Build{
        player_id: player_id,
        coords: {x, y},
        building_id: building_id
      }
    }
  end
end
