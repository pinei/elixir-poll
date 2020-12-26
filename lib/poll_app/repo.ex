defmodule PollApp.Repo do
  use Ecto.Repo,
    otp_app: :poll_app,
    adapter: Ecto.Adapters.Postgres
end
