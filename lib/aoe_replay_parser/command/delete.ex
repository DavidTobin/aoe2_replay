defmodule AoeReplayParser.Command.Delete do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<_::bytes-size(3), object_id::little-integer-size(32),
          player_id::little-integer-size(32)>>
      ) do
    %C{
      type: :delete,
      command: %C.Delete{
        player_id: player_id,
        object_id: object_id
      }
    }
  end
end
