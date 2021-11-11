defmodule GlobalReaderProjectWeb.PasswordRecoveryController do
  use GlobalReaderProjectWeb, :controller
  alias GlobalReaderProject.{Queries, Email, Mailer}

  def new(conn, _params) do
    render(conn, "new.html")
  end
  def create(conn, %{"email" => email}) do
    case Queries.get_user_from_email(email) do
      nil ->
        conn
        |> put_flash(:error, "Email not found")
        |> redirect(to: Routes.password_recovery_path(conn, :new))
      user ->
        user
        |> Queries.set_token_on_user()
        |> Email.pass_reset_email()
        |> Mailer.deliver_later()

        conn
        |> put_flash(:info, "Email sent with password reset instructions")
        |> redirect(to: Routes.password_recovery_path(conn, :new))
    end
  end

  def edit(conn, %{"id" => token}) do
    if user = Queries.get_user_from_token(token) do
      changeset = Queries.change_user(user)
      render(conn, "edit.html", changeset: changeset, user: user)
    else
      render(conn, "invalid_token.html")
    end
  end


  #token - that comes with the link, pass_attrs - new password
  def update(conn, %{"id" => token, "user" => pass_attrs}) do
    user = Queries.get_user_from_token(token)

    #Merge new password with empty password recovery token and password recovery sent time
    pass_attrs = Map.merge(pass_attrs, %{"password_reset_token" => nil, "password_reset_sent_at" => nil})

    with true <- Queries.valid_token?(user.password_reset_sent_at),
          {:ok, _updated_user} <- Queries.update_user(user, pass_attrs) do

          conn
          |> put_flash(:info, "Password reset successful!")
          |> redirect(to: Routes.user_path(conn, :show, user.email)) # Just to demonstrate that password is updated
    else
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Couldn't change the password")
        |> render("edit.html", user: user, changeset: changeset)

      false ->
        conn
        |> put_flash(:error, "Token expired-generate new one")
        |> redirect(to: Routes.password_recovery_path(conn, :new))
    end

  end


end
