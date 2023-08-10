FROM elixir:1.15-slim

ADD ./server.exs .

CMD ["elixir", "server.exs"]
