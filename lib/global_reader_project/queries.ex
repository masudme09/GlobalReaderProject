defmodule GlobalReaderProject.Queries do
  import Ecto.Query, warn: false
  alias GlobalReaderProject.Repo

  alias GlobalReaderProject.Accounts.User

  def get_user_from_email(email) do
    User
    |> Repo.get_by(email: email)
  end

  def get_user_from_token(token) do
    User
    |> Repo.get_by(password_reset_token: token)
  end

  def set_token_on_user(user) do
    props = %{
      "password_reset_token" => SecureRandom.urlsafe_base64(),
      "password_reset_sent_at" => NaiveDateTime.utc_now()
    }

    user
    |> User.changeset(props)
    |> Repo.update!()
  end

  def change_user(user) do
    user
    |>User.changeset_update(user)
  end

  def valid_token?(token_sent_at) do
    current_time = NaiveDateTime.utc_now()
    Time.diff(current_time, token_sent_at) < 10800 # Token valid for 3hrs
  end

  def update_user(user, attrs) do
    user = user |> User.changeset_update(attrs)
    {x,y} = Repo.update(user)
    {x,y}
  end

end
