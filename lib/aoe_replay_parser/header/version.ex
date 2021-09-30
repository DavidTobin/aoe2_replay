defmodule AoeReplayParser.Header.Version do
  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.GameDetails

  def parse(rest, data) do
    <<version::bytes-size(7), _::binary-size(1), save::little-float-size(32), rest::bits>> = rest

    {%GameDetails{data | version: version, save: round(save)}, rest}
  end
end
