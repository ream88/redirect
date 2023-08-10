Mix.install([
  {:plug_cowboy, "~> 2.0"}
])

defmodule Redirect do
  use Plug.Builder

  def init(opts), do: opts

  def call(conn, _opts) do
    case conn.path_info do
      [] ->
        Plug.Conn.send_resp(conn, 404, "Not Found")

      segments ->
        url = "https://api.twilio.com/#{Path.join(segments)}"
        IO.puts("Redirecting to #{url}")

        conn
        |> Plug.Conn.put_resp_header("location", url)
        |> Plug.Conn.send_resp(302, "")
    end
  end
end

port = String.to_integer(System.get_env("PORT", "3000"))

{:ok, _} = Plug.Cowboy.http(Redirect, [], ip: {0, 0, 0, 0}, port: port)
IO.puts("Redirect started at 0.0.0.0:#{port}")

Process.sleep(:infinity)
