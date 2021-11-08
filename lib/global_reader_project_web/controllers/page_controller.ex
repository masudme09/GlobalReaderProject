defmodule GlobalReaderProjectWeb.PageController do
  use GlobalReaderProjectWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
