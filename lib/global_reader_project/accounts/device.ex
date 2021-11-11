defmodule GlobalReaderProject.Accounts.Device do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :industry, :string
    field :model, :string

    belongs_to :user, GlobalReaderProject.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:model, :industry,:user_id])
    |> validate_required([:model, :industry,:user_id])
  end
end
