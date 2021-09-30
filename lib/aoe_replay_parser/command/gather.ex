defmodule AoeReplayParser.Command.Gather do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<length::little-integer-size(8), _::bytes-size(10), x::little-float-size(32),
          y::little-float-size(32), rest::bits>>
      ) do
    {object_ids, _} = copy_objects(length, :int32, rest)

    %C{
      type: :gather,
      command: %C.Gather{
        coords: {x, y},
        object_ids: object_ids
      }
    }
  end
end
