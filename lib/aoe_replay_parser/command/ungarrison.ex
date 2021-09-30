defmodule AoeReplayParser.Command.Ungarrison do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<length::little-signed-integer-size(16), _::bytes-size(1), x::little-float-size(32),
          y::little-float-size(32), _::bytes-size(8), rest::bits>>
      ) do
    {object_ids, _} = copy_objects(length, :int32, rest)

    %C{
      type: :ungarrison,
      command: %C.Ungarrison{
        coords: {x, y},
        object_ids: object_ids
      }
    }
  end
end
