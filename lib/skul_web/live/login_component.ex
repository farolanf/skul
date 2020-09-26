defmodule SkulWeb.LoginComponent do
  use SkulWeb, :live_component

  @impl true
  def handle_event(event, params, socket) do
    IO.inspect {event, params}, label: "args====================="
    do_event(event, params, socket)
  end

  def do_event("login", %{"login" => %{"email" => _email, "password" => _password}}, socket) do
    {:noreply, socket}
  end

  def do_event("register", %{"new_email" => _new_email, "new_password" => _new_password, "new_password_confirmation" => _new_password_confirmation}, socket) do
    {:noreply, socket}
  end

end
