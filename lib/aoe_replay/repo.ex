defmodule AoeReplay.Repo do
  use Ecto.Repo,
    otp_app: :aoe_replay,
    adapter: Ecto.Adapters.Postgres
end
