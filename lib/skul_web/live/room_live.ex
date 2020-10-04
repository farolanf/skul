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
    token = Openvidu.get_token("SessionA")
    socket = push_event(socket, "openvidu_token", %{token: token})
    {:noreply, socket}
  end

end
