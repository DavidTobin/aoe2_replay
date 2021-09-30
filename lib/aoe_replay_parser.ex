defmodule AoeReplayParser do
  require Logger

  alias __MODULE__.{Header, Operations, Reader}

  def parse(game) do
    with {header, body} <- Reader.read(game),
         header_details <- Header.parse(header),
         operations <- Operations.parse(body) do
      {header_details, operations}
    else
      _ -> {:error, :not_parsable}
    end
  end
end
