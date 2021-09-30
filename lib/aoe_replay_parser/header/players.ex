defmodule AoeReplayParser.Header.Players do
  alias AoeReplayParser.Data.GameDetails

  use AoeReplayParser.Parser

  def parse(rest, data) do
    parse(rest, %GameDetails{data | players: []}, 0)
  end

  def parse(rest, data, 8) do
    {data, rest}
  end

  def parse(rest, data, player_num) do
    <<_::bytes-size(4), color_id::little-integer-signed-size(32), _::bytes-size(12),
      civ_id::little-integer-size(32), rest::binary>> = rest

    {_, rest} = read_string(rest)

    <<_::bytes-size(1), rest::binary>> = rest

    {_, rest} = read_string(rest)
    {name, rest} = read_string(rest)

    <<_::bytes-size(4), profile_id::little-integer-size(32), _::binary-size(4),
      player_id::signed-little-integer-size(32), _::bytes-size(10), rest::binary>> = rest

    player = %{
      id: player_id,
      name: name,
      civ_id: civ_id,
      color_id: color_id,
      profile_id: profile_id
    }

    parse(rest, %GameDetails{data | players: [player | data.players]}, player_num + 1)
  end
end
