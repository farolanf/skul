defmodule SkulWeb.RoomLive do
  use SkulWeb, :live_view

  alias Skul.Openvidu

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, socket}
  end

  @impl true
  def handle_event("get_token", _params, socket) do
    socket = socket
    |> assign(session_token: Openvidu.get_token("SessionA"))
    {:noreply, socket}
  end

end
