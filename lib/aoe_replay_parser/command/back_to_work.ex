defmodule AoeReplayParser.Command.BackToWork do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(<<_::bytes-size(3), object_id::little-integer-size(32)>>) do
    %C{
      type: :back_to_work,
      command: %C.BackToWork{
        object_id: object_id
      }
    }
  end
end
