defmodule TelegramBot.Commander.Voice do  
  use GenServer
  alias Nadia.Model.{Message, Voice}

  @messages [
    "Fuck off !",
    "Серьезно ? Я похож на того, кто понимает обезьяний ?",
    "Да этим голосом ток в туалете орать занято."
  ]

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def get_answer(_), do: Enum.take_random(@messages, 1)


  def handle_cast(%Message{chat: %{id: chat_id}} = message, state) do
    Nadia.send_message(chat_id, get_answer(message))
    {:noreply, state}
  end

  def handle(%Message{voice: %Voice{}} = message) do
    GenServer.cast(__MODULE__, message)
  end

  def handle(_), do: :ok
end
