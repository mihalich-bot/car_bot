defmodule TelegramBot.Handler.Voice do
  use GenServer
  alias Nadia.Model.{Message, Voice}
  alias Commander.Model.Command
  alias TelegramBot.Replier

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def handle(%Message{voice: %Voice{}} = message) do
    Commander.handle({:command, %Command{from: __MODULE__, reply_to: Replier, command: :fuck_off, custom: message}})
  end

  def handle(_), do: :ok
end
