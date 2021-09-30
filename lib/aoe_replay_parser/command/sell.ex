defmodule AoeReplayParser.Command.Sell do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(
        <<player_id::little-integer-size(8), resource_id::little-integer-size(8),
          amount::little-integer-size(8), _::bits>>
      ) do
    %C{
      type: :sell,
      command: %C.Sell{
        player_id: player_id,
        resource_id: resource_id,
        amount: amount
      }
    }
  end
end
