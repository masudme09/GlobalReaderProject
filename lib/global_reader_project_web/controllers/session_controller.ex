defmodule GlobalReaderProjectWeb.SessionController do
  use GlobalReaderProjectWeb, :controller
  alias GlobalReaderProject.{Repo, Accounts.User}

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
