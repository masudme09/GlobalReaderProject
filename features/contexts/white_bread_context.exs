defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers

  alias GlobalReaderProject.{Repo, Accounts.User}

  feature_starting_state fn  ->
    Application.ensure_all_started(:hound)
    %{}
  end
  scenario_starting_state fn _state ->
    Hound.start_session
    %{}
  end
  scenario_finalize fn _status, _state ->
    Hound.end_session
  end


  given_ ~r/^the following user are on the system$/, fn state,  %{table_data: table} ->
    table
    |> Enum.map(fn user -> User.changeset(%User{}, user) end)
    |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
    {:ok, state}
  end
  and_ ~r/^I open GlobalReader home page$/, fn state ->
    navigate_to("/")
    {:ok, state}
  end
  and_ ~r/^I clicked on Login Button$/, fn state ->
    click({:id, "login-button"})
    :timer.sleep(3000)
    {:ok, state}
  end
  and_ ~r/^I enterred my username "(?<username>[^"]+)" and password "(?<password>[^"]+)"$/,
  fn state, %{username: username,password: password} ->
    fill_field({:id, "txtio_username"}, username)
    fill_field({:id, "txtio_password"}, password)
    {:ok,state}
  end
  when_ ~r/^I submit the information$/, fn state ->
    click({:id, "submit-button"})
    {:ok, state}
  end
  then_ ~r/^I should receive a sucessful login confirmation message$/, fn state ->
    :timer.sleep(3000)
    assert visible_in_page?(~r/Login Successful/)
    {:ok, state}
  end
  # for falied login scenario
  then_ ~r/^I should receive a failed login message$/, fn state ->
    :timer.sleep(3000)
    assert visible_in_page?(~r/Bad Credentials/)
    {:ok, state}
  end
end
