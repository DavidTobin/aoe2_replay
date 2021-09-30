defmodule AoeReplayParser.Operations.Sync do
  require Logger

  alias AoeReplayParser.Data.Sync, as: SyncData

  def parse(data) do
    <<increment::little-integer-size(32), marker::little-integer-size(32), _::bits>> = data

    rest =
      if marker == 0 do
        <<_::bytes-size(12), checksum::little-integer-size(32), _::bytes-size(4),
          seq::little-integer-size(32), r::bits>> = data

        Logger.info("Checksum: #{checksum}")

        if seq > 0 do
          <<_::bytes-size(340), r::bits>> = r
          r
        else
          <<_::bytes-size(8), r::bits>> = r
          r
        end
      else
        <<_::little-integer-size(32), rest::bits>> = data
        rest
      end

    {%SyncData{increment: increment}, rest}
  end
end
