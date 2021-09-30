defmodule Recovery.Repo do
  use Ecto.Repo,
    otp_app: :recovery,
    adapter: Ecto.Adapters.Postgres
end
