defmodule Skul.Email do
  use Bamboo.Phoenix, view: SkulWeb.EmailView
  import Bamboo.Email

  def welcome_email(attrs) do
    base_email(
      to: attrs[:to],
      subject: "Selamat datang di skul.id!"
    )
    |> render(:welcome, %{to: attrs[:to], name: attrs[:name]})
  end

  defp base_email(attrs) do
    new_email(
      Keyword.merge(
        [
          from: "noreply@skul.id",
        ],
        attrs
      )
    )
  end

end
