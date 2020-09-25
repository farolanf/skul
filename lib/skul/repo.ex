defmodule Skul.Repo do
  use Ecto.Repo,
    otp_app: :skul,
    adapter: Ecto.Adapters.Postgres
end
