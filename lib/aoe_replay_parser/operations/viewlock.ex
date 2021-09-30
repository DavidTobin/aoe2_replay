defmodule AoeReplayParser.Operations.Viewlock do
  alias AoeReplayParser.Data.Viewlock, as: ViewlockData

  def parse(
        <<x::little-float-size(32), y::little-float-size(32), _::integer-little-size(32),
          rest::bits>>
      ) do
    {%ViewlockData{coords: {x, y}}, rest}
  end
end
