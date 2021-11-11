defmodule GlobalReaderProject.Accounts.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :name, :string

    belongs_to :user, GlobalReaderProject.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name,:user_id])
    |> validate_required([:name,:user_id])
  end
end
