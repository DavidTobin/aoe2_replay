defmodule AoeReplayParser.Command.Research do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<_::bytes-size(3), object_id::little-integer-size(32),
          player_id::little-signed-integer-size(16), _::bytes-size(2),
          technology_id::little-integer-size(32), _::bits>>
      ) do
    %C{
      type: :research,
      command: %C.Research{
        player_id: player_id,
        object_id: object_id,
        technology_id: technology_id
      }
    }
  end
end
