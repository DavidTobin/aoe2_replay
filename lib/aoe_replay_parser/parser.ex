defmodule AoeReplayParser.Parser do
  defmacro __using__(_opts) do
    quote do
      require Logger

      defp copy_objects(object_count, type, rest), do: copy_objects(object_count, type, [], rest)
      defp copy_objects(0, _, acc, rest), do: {acc, rest}

      defp copy_objects(
             object_count,
             :int32,
             acc,
             <<object_id::integer-little-size(32), rest::bits>>
           ) do
        copy_objects(object_count - 1, :int32, [object_id | acc], rest)
      end

      defp copy_objects(
             object_count,
             :int8,
             acc,
             <<object_id::integer-little-size(8), rest::bits>>
           ) do
        copy_objects(object_count - 1, :int8, [object_id | acc], rest)
      end

      defp read_string(<<_::bytes-size(2), length::little-integer-signed-size(16), rest::bits>>) do
        <<string::bytes-size(length), rest::bits>> = rest

        {string, rest}
      end
    end
  end
end
