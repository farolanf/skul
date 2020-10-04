defmodule Skul.Openvidu do

  def get_token(session_id) do
    case create_session(session_id) do
      {:ok, session_id} ->
        case create_token(session_id) do
          {:ok, token} -> token
          _ -> nil
        end
      _ -> nil
    end
  end

  def create_session(session_id) do
    case post("/api/sessions", %{customSessionId: session_id}) do
      %{status_code: 200, body: body} ->
        {:ok, body}
      %{status_code: 409} ->
        {:ok, session_id}
      response ->
        IO.inspect response, label: "error"
        {:error, "Internal error"}
    end
  end

  def create_token(session_id) do
    case post("/api/tokens", %{session: session_id}) do
      %{status_code: 200, body: body} ->
        body = Jason.decode!(body)
        {:ok, body["token"]}
      response ->
        IO.inspect response, label: "error"
        {:error, "Internal error"}
    end
  end

  def post(path, body) do
    HTTPoison.post!(
      server_url() <> path,
      Jason.encode!(body),
      headers(),
      options())
  end

  def server_url do
    Application.fetch_env!(:skul, :openvidu)[:url]
  end

  def headers do
    config = Application.fetch_env!(:skul, :openvidu)
    encoded_userpass = Base.encode64("#{config[:user]}:#{config[:password]}")
    [
      {"Authorization", "Basic #{encoded_userpass}"},
      {"Content-Type", "application/json"}
    ]
  end

  def options do
    [hackney: [:insecure]]
  end

end
