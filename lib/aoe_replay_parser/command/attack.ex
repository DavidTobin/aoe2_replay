defmodule AoeReplayParser.Command.Attack do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command

  def parse(
        <<player_id::integer-little-size(8), _::integer-little-size(16),
          target_id::integer-little-size(32), selected_units::integer-little-size(8),
          _::integer-little-size(24), x::float-little-size(32), y::float-little-size(32),
          rest::bits>>
      ) do
    {attacker_ids, rest} = copy_objects(selected_units, :int32, [], rest)

    %Command{
      type: :attack,
      command: %Command.Attack{
        player_id: player_id,
        target_id: target_id,
        coords: {x, y},
        attacker_ids: attacker_ids
      }
    }
  end
end
