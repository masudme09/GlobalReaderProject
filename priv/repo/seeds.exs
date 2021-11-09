alias GlobalReaderProject.{Accounts.User, Repo}

[%{name: "Ulrich Hansan", username: "ulha", password: "doIneedOne", email: "ulha@testing.com"},
 %{name: "Mlrich Hansan", username: "mlha", password: "doIneedOneAlso", email: "mlha@testing.com"}]
|> Enum.map(fn user_data -> User.changeset(%User{}, user_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)
