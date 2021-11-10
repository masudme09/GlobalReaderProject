defmodule GlobalReaderProjectWeb.LoginController do
  use GlobalReaderProjectWeb, :controller

  def index(conn, _params) do
    render(conn, "login.html")
  end

  def create(conn, _params) do
    render(conn, "login.html")
  end
end
