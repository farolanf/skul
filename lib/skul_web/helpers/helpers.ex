defmodule SkulWeb.Helpers do

  import Phoenix.LiveView
  import Phoenix.HTML.Tag

  alias Skul.Accounts

  def assign_defaults(session, socket) do
    with %{"user_id" => user_id} <- session,
        false <- Map.has_key?(socket.assigns, :user),
        user when not is_nil(user) <- Accounts.get_user(user_id) do
      socket |> assign(:user, user)
    else
      _ -> socket
    end
  end

  def svelte(component, %{} = props \\ %{}) when is_binary(component) do
    html = "#{File.cwd!()}/assets/js/svelte/#{component}.svelte"
    |> SvelteRender.render(props)
    component_id = String.replace(component, "/", "-")
    content_tag(:div, html,
      id: "sveltex-#{component_id}",
      data: [props: Jason.encode!(props)],
      phx_hook: "svelte"
    )
  end

end
