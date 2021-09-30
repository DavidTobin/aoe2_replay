defmodule AoeReplayParser.Command do
  alias AoeReplayParser.Data.Command, as: C

  @callback parse(binary()) :: {C.t(), binary()}
end
