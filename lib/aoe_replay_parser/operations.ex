defmodule AoeReplayParser.Operations do
  require Logger

  alias AoeReplayParser.Command
  alias __MODULE__.{Command, Viewlock, Sync, Chat}

  @operations %{
    1 => :action,
    2 => :sync,
    3 => :viewlock,
    4 => :chat,
    5 => :start,
    6 => :save
  }

  def parse(<<_::little-integer-size(32), _::bytes-size(20), data::bits>>) do
    parse(data, [])
  end

  def parse(<<op::integer-size(32)-little, rest::bits>>, acc) do
    case @operations[op] do
      :action ->
        Command.parse(rest)

      :sync ->
        Sync.parse(rest)

      :viewlock ->
        Viewlock.parse(rest)

      :chat ->
        Chat.parse(rest)

      _ ->
        {:error, rest}
    end
    |> parse(acc)
  end

  def parse({nil, rest}, acc), do: parse(rest, acc)
  def parse({item, rest}, acc), do: parse(rest, [item | acc])

  def parse(_, acc), do: Enum.reverse(acc)
end
