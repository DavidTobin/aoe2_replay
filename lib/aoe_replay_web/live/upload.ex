defmodule AoeReplayWeb.UploadLive do
  use AoeReplayWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:game, nil)
     |> assign(:operations, [])
     |> allow_upload(:replay, accept: :any, max_entries: 1, max_file_size: 20_000_000)}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :avatar, ref)}
  end

  @impl Phoenix.LiveView
  def handle_event("save", _params, socket) do
    [{game, operations}] =
      consume_uploaded_entries(socket, :replay, fn %{path: path}, _entry ->
        {:ok, data} = File.read(path)

        AoeReplayParser.parse(data)
      end)

    operations =
      operations
      |> Enum.filter(fn op ->
        if op.__struct__ == AoeReplayParser.Data.Command do
          op.command.__struct__ != AoeReplayParser.Data.Command.Unknown and
            op.command.__struct__ != AoeReplayParser.Data.Command.Stop
        else
          op.__struct__ != AoeReplayParser.Data.Viewlock and
            op.__struct__ != AoeReplayParser.Data.Sync
        end
      end)

    {:noreply,
     socket
     |> assign(:game, game)
     |> assign(:operations, operations)}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
      <%= if @game do %>
        <%= for player <- @game.players do %>
          <%= if player.civ_id != 15 do %>
            <div>
              <%= player.name %> playing as <%= player.civ_id %>
            </div>
          <% end %>
        <% end %>

        <ul>
          <%= for operation <- @operations do %>
            <li><%= inspect(operation) %></li>
          <% end %>
        </ul>
      <% else %>

        <form id="upload-form" phx-change="validate" phx-submit="save">
          <%= live_file_input @uploads.replay %>

          <%= if length(@uploads.replay.entries) > 0 do %>
            <div phx-drop-target={@uploads.replay.ref} class="grid">
              <%= for entry <- @uploads.replay.entries do %>
                <article>
                  <h1><%= entry.client_name %></h1>

                  <progress value={entry.progress} max="100"> <%= entry.progress %>% </progress>

                  <button type="submit">Upload</button>
                </article>
              <% end %>
            </div>
          <% end %>
        </form>
      <% end %>
    """
  end
end
