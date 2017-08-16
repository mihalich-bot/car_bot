defmodule TelegramBot.Replier do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def handle_cast({:reply_text, text, %{custom: %{chat: %{id: chat_id}}}}, state) do
    Nadia.send_message(chat_id, text)
    {:noreply, state}
  end

  def handle_cast(data, state) do
    IO.inspect data
    {:noreply, state}
  end
  def handle_cast(_, state), do: {:noreply, state}
end
