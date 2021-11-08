defmodule GlobalReaderProject.Repo do
  use Ecto.Repo,
    otp_app: :global_reader_project,
    adapter: Ecto.Adapters.Postgres
end
