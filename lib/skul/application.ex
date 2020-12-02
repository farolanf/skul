defmodule Skul.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Skul.Repo,
      # Start the Telemetry supervisor
      SkulWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Skul.PubSub},
      # Start the Endpoint (http/https)
      SkulWeb.Endpoint,
      %{
        id: SvelteRender,
        start: {SvelteRender, :start_link, [[render_service_path: "#{File.cwd!()}/assets/js", pool_size: 4]]},
        type: :supervisor
      }
      # Start a worker by calling: Skul.Worker.start_link(arg)
      # {Skul.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Skul.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SkulWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
