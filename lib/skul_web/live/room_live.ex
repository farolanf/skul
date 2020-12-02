defmodule SkulWeb.RoomLive do
  use SkulWeb, :live_view

  alias Skul.Openvidu

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    |> assign(name: "world!")
    {:ok, socket}
  end

  @impl true
  def handle_event("get_token", _params, socket) do
    token = Openvidu.get_token("SessionA")
    socket = push_event(socket, "openvidu_token", %{token: token})
    {:noreply, socket}
  end

  @impl true
  def handle_event("test-event", _params, socket) do
    {:noreply, %{name: "ok girls!"}, socket}
  end

  @impl true
  def handle_event("update_name", _params, socket) do
    {:noreply, assign(socket, name: "Girls!")}
  end

end
