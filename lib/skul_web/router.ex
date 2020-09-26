defmodule SkulWeb.Router do
  use SkulWeb, :router

  alias Skul.Accounts

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SkulWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :load_user
  end

  pipeline :protected do
    plug :ensure_authenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SkulWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/login", PageLive, :login
    live "/register", PageLive, :register
    post "/session/new", SessionController, :new
    delete "/logout", SessionController, :delete
  end

  scope "/", SkulWeb do
    pipe_through [:browser, :protected]

    live "/profile", PageLive, :profile
  end

  def load_user(conn, _) do
    with user_id when not is_nil(user_id) <- get_session(conn, :user_id),
        user when not is_nil(user) <- Accounts.get_user(user_id) do
      conn |> assign(:user, user)
    else
      _ -> conn |> delete_session(:user_id)
    end
  end

  def ensure_authenticated(%{assigns: %{user: _}} = conn, _), do: conn

  def ensure_authenticated(
    %{request_path: request_path, query_string: query_string} = conn,
    _
  ) do
    redirect_url = "#{request_path}?#{query_string}"
    conn
    |> put_session(:redirect_url, redirect_url)
    |> put_flash(:login, "Please login before accessing the page.")
    |> redirect(to: "/")
  end

  # Other scopes may use custom stacks.
  # scope "/api", SkulWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: SkulWeb.Telemetry
    end
  end
end
