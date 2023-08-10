FROM elixir:1.15-slim

ADD ./server.exs .

# Install dependencies
RUN elixir server.exs

CMD ["elixir", "server.exs", "--no-halt"]
