defmodule TelegramBot.Handler.Text do
  use GenServer
  alias Nadia.Model.Message
  alias TelegramBot.Replier
  alias NlpProcessor.Model.Query

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def handle(%Message{text: text, chat: %{id: chat_id}} = message) do
    # GenServer.cast(__MODULE__, {text, message})
    NlpProcessor.process(%Query{from: __MODULE__, reply_to: Replier, query: text, session_id: chat_id, custom: message})
  end

  def handle(_), do: :ok

  def handle_cast({text, _}, state) do
    IO.inspect text
    {:noreply, state}
  end

end
