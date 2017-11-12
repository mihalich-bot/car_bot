defmodule TelegramBot.Handler.Supervisor do
  use Supervisor

  def init(stack), do: {:ok, stack}

  def start_link do
    import Supervisor.Spec

    children = [
      worker(TelegramBot.Handler.Text, []),
      worker(TelegramBot.Handler.Voice, [])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
