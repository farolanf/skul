defmodule SkulWeb.PageLive do
  use SkulWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def handle_event("test_email", _params, socket) do
    if socket.assigns[:user] |> can?(:send, :test_email) do
      Skul.Email.welcome_email(to: "some1@test.com", name: "budi")
      |> Skul.Mailer.deliver_now()
      {:noreply, socket |> put_flash(:success, "Email sent!")}
    else
      socket = socket
      |> put_flash(:error, "Access denied")
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      %{^query => vsn} ->
        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    if not SkulWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end
end
