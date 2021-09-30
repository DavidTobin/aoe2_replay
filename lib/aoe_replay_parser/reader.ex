defmodule AoeReplayParser.Reader do
  def read(<<header_size::little-integer-size(32), _::little-integer-size(32), data::bits>>) do
    inflate_header(data, header_size)
  end

  def read(_), do: {:error, :invalid_replay}

  def inflate_header(data, header_size) do
    <<header::binary-size(header_size), body::bits>> = data

    z = :zlib.open()
    :zlib.inflateInit(z, -15)

    header = :zlib.inflate(z, header) |> :erlang.iolist_to_binary()

    {header, body}
  end
end
