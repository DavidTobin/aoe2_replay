defmodule AoeReplayParser.Command.Queue do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command

  def parse(
        <<player_id::little-integer-size(8), _::bytes-size(2), length::little-integer-size(8),
          _::bytes-size(1), unit_id::little-signed-integer-size(16),
          amount::little-integer-size(8), rest::bits>>
      ) do
    {object_ids, _} = copy_objects(length, :int32, rest)

    %Command{
      type: :queue,
      command: %Command.Queue{
        player_id: player_id,
        unit_id: unit_id,
        amount: amount,
        object_ids: object_ids
      }
    }
  end
end
