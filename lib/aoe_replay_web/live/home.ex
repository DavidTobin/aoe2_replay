defmodule AoeReplayWeb.HomeLive do
  use AoeReplayWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
      <h1>Home</h1>
    """
  end
end
