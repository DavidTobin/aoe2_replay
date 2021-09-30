defmodule AoeReplayWeb.PageController do
  use AoeReplayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
