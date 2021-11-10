defmodule GlobalReaderProject.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :username, :string
    field :password_reset_token, :string
    field :password_reset_sent_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :email, :password, :password_reset_token, :password_reset_sent_at ])
    |> validate_required([:name, :username, :email, :password])
  end

  def changeset_update(user, attrs) do
    user
    |> cast(attrs, [])
  end
end
