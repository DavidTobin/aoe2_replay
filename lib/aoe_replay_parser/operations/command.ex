defmodule AoeReplayParser.Operations.Command do
  alias AoeReplayParser.Data.Command, as: C
  alias AoeReplayParser.Command

  @ignore_commands [2, 10, 100, 130, 131, 135, 34, 35, 37, 39, 41, 53, 109, 103, 117]

  def parse(<<size::little-integer-size(32), action_id::little-integer-size(8), rest::bits>>) do
    size = size - 1
    <<command::binary-size(size), _::bytes-size(4), rest::bits>> = rest

    {case action_id do
       0 -> Command.Order.parse(command)
       1 -> Command.Stop.parse(command)
       3 -> Command.Move.parse(command)
       11 -> Command.Resign.parse(command)
       18 -> Command.Stance.parse(command)
       21 -> Command.Patrol.parse(command)
       23 -> Command.Formation.parse(command)
       101 -> Command.Research.parse(command)
       102 -> Command.Build.parse(command)
       105 -> Command.Wall.parse(command)
       106 -> Command.Delete.parse(command)
       111 -> Command.Ungarrison.parse(command)
       120 -> Command.Gather.parse(command)
       122 -> Command.Sell.parse(command)
       123 -> Command.Buy.parse(command)
       127 -> Command.TownBell.parse(command)
       128 -> Command.BackToWork.parse(command)
       129 -> Command.Queue.parse(command)
       a when a in @ignore_commands -> nil
       _ -> %C.Unknown{action_id: action_id}
     end, rest}
  end
end
