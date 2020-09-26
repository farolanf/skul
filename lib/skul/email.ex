defmodule Skul.Email do
  use Bamboo.Phoenix, view: SkulWeb.EmailView
  import Bamboo.Email

  def welcome_email(attrs) do
    base_email(
      to: Keyword.get(attrs, :to),
      subject: "Selamat datang di skul.id!"
    )
    |> render(:welcome, %{to: Keyword.get(attrs, :to), name: Keyword.get(attrs, :name)})
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
