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
    field :devices_count, :integer, virtual: true
    field :jobs_count, :integer, virtual: true

    has_many :devices , GlobalReaderProject.Accounts.Device
    has_many :jobs , GlobalReaderProject.Accounts.Job

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :email, :password, :password_reset_token, :password_reset_sent_at, :devices_count, :jobs_count ])
    |> validate_required([:name, :username, :email, :password])
  end

  def changeset_update(user, attrs) do
    user
    |> cast(attrs, [])
  end
end
