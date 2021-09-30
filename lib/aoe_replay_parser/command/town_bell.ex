defmodule AoeReplayParser.Command.TownBell do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(<<_::bytes-size(3), object_id::little-integer-size(32), _::bits>>) do
    %C{
      type: :town_bell,
      command: %C.TownBell{
        object_id: object_id
      }
    }
  end
end
