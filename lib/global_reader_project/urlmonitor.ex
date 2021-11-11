defmodule GlobalReaderProject.UrlMonitor do
  use GenServer
  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(state) do
    start_url_monitor()
    {:ok, state}
  end

  def handle_info(:request_sent, state) do
    {requset_time, result} = :timer.tc(fn -> HTTPoison.get!("https://apis.globalreader.eu/health") end)

    body = result |> Map.get(:body)
    response_code = result |> Map.get(:status_code)

    requset_time_ms = 0.001 * requset_time

    if requset_time_ms< 400 do
      IO.inspect("response code: $#{response_code}")
      IO.inspect("response body: $#{body}")
      IO.inspect("response time: $#{requset_time_ms}")
      start_url_monitor()
    else
      IO.inspect("error")
      start_url_monitor()
    end

    {:noreply, state}
  end

  defp start_url_monitor() do
    Process.send_after(self(), :request_sent, 30000)
  end
end
