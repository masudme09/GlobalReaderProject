alias GlobalReaderProject.{Accounts.User,Accounts.Job,Accounts.Device, Repo}

[%{name: "Ulrich Hansan", username: "ulha", password: "doIneedOne", email: "ulha@testing.com"},
 %{name: "Mlrich Hansan", username: "mlha", password: "doIneedOneAlso", email: "mlha@testing.com"}]
|> Enum.map(fn user_data -> User.changeset(%User{}, user_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)


[%{name: "get_milk", user_id: 1 },%{name: "get_bread", user_id: 1 },%{name: "get_chips", user_id: 2 } ,%{name: "get_tintit", user_id: 2 }]
|> Enum.map(fn job_data -> Job.changeset(%Job{}, job_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)

[%{model: "C90788",industry: "milk", user_id: 1 },%{model: "C90780",industry: "milk", user_id: 1  },%{model: "C91780",industry: "agro", user_id: 2  }]
|> Enum.map(fn device_data -> Device.changeset(%Device{}, device_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)
