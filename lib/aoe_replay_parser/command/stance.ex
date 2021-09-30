defmodule AoeReplayParser.Command.Stance do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command, as: C

  def parse(<<length::little-integer-size(8), stance_id::little-integer-size(8), rest::bits>>) do
    {object_ids, _} = copy_objects(length, :int32, rest)

    %C{
      type: :stance,
      command: %C.Stance{
        stance_id: stance_id,
        object_ids: object_ids
      }
    }
  end
end
