defmodule GlobalReaderProjectWeb.UserController do
  use GlobalReaderProjectWeb, :controller
  alias GlobalReaderProject.{Repo, Accounts.User,Accounts.Device,Accounts.Job, Queries}
  import Ecto.Query
  require Logger


  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => email}) do
    user = Queries.get_user_from_email(email)
    render(conn, "show.html", user: user)
  end

  def get_user_info(conn, _params) do

    query = from u in User,
            join: d in Device, on: d.user_id == u.id, distinct: true,
            join: j in Job, on: j.user_id == u.id,
            group_by: u.id,
            select: %{id: u.id, name: u.name, email: u.email, username: u.username,
            devices_count: count(fragment("DISTINCT ?", d.id)), jobs_count: count(fragment("DISTINCT ?", j.id))}

    data = query |> Repo.all() |> Enum.map(fn(user) -> struct(User, user) end)
    Logger.info("ResultTest : #{inspect(data)}")

    render( conn, "info.html", data: data )
  end


end
