defmodule AoeReplayParser.Operations.Chat do
  alias AoeReplayParser.Data.Chat, as: ChatData

  use AoeReplayParser.Parser

  def parse(<<_::bytes-size(4), length::little-integer-size(32), data::bits>>) do
    <<msg::bytes-size(length), rest::bits>> = data

    {%ChatData{msg: msg}, rest}
  end
end
