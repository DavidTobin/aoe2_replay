defmodule AoeReplayParser.Command.Order do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command

  def parse(
        <<player_id::integer-little-size(8), _::bytes-size(2), target_id::integer-little-size(32),
          units_count::integer-signed-little-size(16), _::bytes-size(2), x::float-little-size(32),
          y::float-little-size(32), rest::bits>>
      ) do
    <<next::signed-integer-size(8), _::bits>> = rest

    {_next, _flags, rest} =
      if next in [0, 1] do
        {-1, -1, rest}
      else
        <<_::bytes-size(8), flags::bytes-size(8), r::bits>> = rest

        {next, flags, r}
      end

    object_ids =
      if units_count == 255 do
        []
      else
        {object_ids, _} = copy_objects(units_count, :int32, rest)
        object_ids
      end

    %Command{
      type: :order,
      command: %Command.Order{
        player_id: player_id,
        target_id: target_id,
        coords: {x, y},
        units: object_ids
      }
    }
  end
end
