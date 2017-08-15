defmodule TelegramBot.Commander.Supervisor do
  use Supervisor

  def start_link do
    import Supervisor.Spec

    children = [
      worker(TelegramBot.Commander.Text, []),
      worker(TelegramBot.Commander.Voice, [])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
