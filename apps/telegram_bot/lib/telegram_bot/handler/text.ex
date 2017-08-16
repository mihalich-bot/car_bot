defmodule TelegramBot.Handler.Text do
  use GenServer
  alias Nadia.Model.Message
  alias Commander.Model.Command
  alias TelegramBot.Replier

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def handle(%Message{text: text} = message) do
    GenServer.cast(__MODULE__, {text, message})
  end

  def handle(_), do: :ok

  def handle_cast({text, message}, state) do
    IO.inspect text
    {:noreply, state}
  end

end
