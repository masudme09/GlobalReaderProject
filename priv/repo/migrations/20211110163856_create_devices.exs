defmodule GlobalReaderProject.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :model, :string
      add :industry, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:devices, [:user_id])
  end
end
