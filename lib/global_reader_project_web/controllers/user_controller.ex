defmodule GlobalReaderProjectWeb.UserController do
  use GlobalReaderProjectWeb, :controller
  alias GlobalReaderProject.{Repo, Accounts.User, Queries}

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"email" => email}) do
    users = Queries.get_user_from_email(email)
    render(conn, "index.html", users: users)
  end
end
