defmodule GlobalReaderProject.Email do
  use Bamboo.Phoenix, view: GlobalReaderProjectWeb.EmailView

  def pass_reset_email(user) do
    new_email()
    |> from("reset_pass@globalreader.eu")
    |> to(user.email)
    |> subject("Password Reset Request")
    |> put_html_layout({GlobalReaderProjectWeb.LayoutView, "email.html"})
    |> assign(:user, user)
    |> render("password_reset.html" , email: user.email)
  end

end
