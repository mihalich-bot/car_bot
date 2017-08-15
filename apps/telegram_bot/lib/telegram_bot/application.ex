defmodule TelegramBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # List all child processes to be supervised
    children = [
      worker(TelegramBot.Poller, []),
      worker(TelegramBot.Matcher, []),
      worker(TelegramBot.Commander.Supervisor, [])
      # Starts a worker by calling: TelegramBot.Worker.start_link(arg)
      # {TelegramBot.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TelegramBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
