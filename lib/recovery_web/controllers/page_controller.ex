defmodule RecoveryWeb.PageController do
  use RecoveryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
