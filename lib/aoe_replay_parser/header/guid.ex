defmodule AoeReplayParser.Header.Guid do
  use AoeReplayParser.Parser

  alias AoeReplayParser.Data.GameDetails

  def parse(<<_::bytes-size(33), rest::bits>>, data) do
    rest = move_cursor(rest, 23)

    <<_::bytes-size(236), rest::bits>> = rest

    <<l::little-integer-size(64), rest::bits>> = rest

    rest = move_l(rest, l)

    <<guid::bytes-size(16), rest::bits>> = rest

    {_, rest} = read_string(rest)
    {_, rest} = read_string(rest)

    <<_::bytes-size(42), rest::bits>> = rest

    {_, rest} = read_string(rest)

    <<_::bytes-size(8), rest::bits>> = rest

    {%GameDetails{data | guid: UUID.binary_to_string!(guid)}, rest}
  end

  defp move_cursor(data, 0), do: data

  defp move_cursor(data, n) do
    {_, rest} = read_string(data)

    <<m::little-integer-size(32), rest::bits>> = rest

    rest = move_m(rest, m)

    move_cursor(rest, n - 1)
  end

  defp move_m(rest, m) when m in [3, 21, 23, 42, 44, 45, 46] do
    <<m::little-integer-size(32), rest::bits>> = rest

    move_m(rest, m)
  end

  defp move_m(rest, _), do: rest

  defp move_l(rest, 0), do: rest

  defp move_l(rest, l) do
    <<_::bytes-size(4), rest::bits>> = rest

    read_string(rest)

    <<_::bytes-size(4), rest::bits>> = rest

    move_l(rest, l - 1)
  end
end
