defmodule AoeReplayParser.Command.Formation do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<length::little-integer-size(8), player_id::little-signed-integer-size(16),
          formation_id::little-integer-size(32), rest::bits>>
      ) do
    {object_ids, _} = copy_objects(length, :int32, rest)

    %C{
      type: :formation,
      command: %C.Formation{
        player_id: player_id,
        formation_id: formation_id,
        object_ids: object_ids
      }
    }
  end
end
