defmodule AoeReplayParser.Header.Dlc do
  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.GameDetails

  def parse(rest, data) do
    <<_::bytes-size(12), dlc_count::little-integer-size(32), rest::bits>> = rest

    dlc_bytes = dlc_count * 4 + 103
    <<_::bytes-size(dlc_bytes), rest::bits>> = rest

    {%GameDetails{data | dlc_count: dlc_count}, rest}
  end
end
