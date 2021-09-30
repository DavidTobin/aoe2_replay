defmodule AoeReplayParser.Data.Command do
  defstruct [:type, :command]

  defmodule Stop do
    defstruct [:object_ids]
  end

  defmodule Attack do
    defstruct [:player_id, :target_id, :coords, :attacker_ids]
  end

  defmodule Move do
    defstruct [:player_id, :coords, :units]
  end

  defmodule Order do
    defstruct [:player_id, :target_id, :coords, :units]
  end

  defmodule Unknown do
    defstruct [:action_id]
  end

  defmodule Game do
    defstruct [:player_id, :mode_id]
  end

  defmodule Build do
    defstruct [:player_id, :coords, :building_id]
  end

  defmodule Queue do
    defstruct [:player_id, :unit_id, :amount, :object_ids]
  end

  defmodule Gather do
    defstruct [:coords, :object_ids]
  end

  defmodule BackToWork do
    defstruct [:object_id]
  end

  defmodule Research do
    defstruct [:player_id, :object_id, :technology_id]
  end

  defmodule Stance do
    defstruct [:stance_id, :object_ids]
  end

  defmodule Ungarrison do
    defstruct [:coords, :object_ids]
  end

  defmodule Formation do
    defstruct [:player_id, :formation_id, :object_ids]
  end

  defmodule Patrol do
    defstruct [:coords, :object_ids]
  end

  defmodule Wall do
    defstruct [:player_id, :coords]
  end

  defmodule Delete do
    defstruct [:player_id, :object_id]
  end

  defmodule Buy do
    defstruct [:player_id, :resource_id, :amount]
  end

  defmodule Sell do
    defstruct [:player_id, :resource_id, :amount]
  end

  defmodule Resign do
    defstruct [:player_id]
  end

  defmodule TownBell do
    defstruct [:object_id]
  end
end
