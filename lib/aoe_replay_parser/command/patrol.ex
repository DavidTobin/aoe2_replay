defmodule AoeReplayParser.Command.Patrol do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<length::little-signed-integer-size(8), _::bytes-size(2), x::little-float-size(32),
          _::bytes-size(36), y::little-float-size(32), _::bytes-size(36), rest::bits>>
      ) do
    {object_ids, _} = copy_objects(length, :int32, rest)

    %C{
      type: :patrol,
      command: %C.Patrol{
        coords: {x, y},
        object_ids: object_ids
      }
    }
  end
end
