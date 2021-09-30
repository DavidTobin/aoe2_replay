defmodule AoeReplayParser.Command.Stop do
  @behaviour AoeReplayParser.Command

  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.Command

  def parse(<<object_count::little-integer-size(8), rest::bits>>) do
    {object_ids, _rest} = copy_objects(object_count, :int32, [], rest)

    %Command{type: :stop, command: %Command.Stop{object_ids: object_ids}}
  end
end
