defmodule TelegramBot.Commander.Text do 
  use GenServer
  alias Nadia.Model.Message

  @ping_regex ~r/ping|пинг/iu

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def handle(%Message{text: text} = message) do
    GenServer.cast(__MODULE__, {text, message})
  end

  def handle(_), do: :ok

  def handle_cast({text, %Message{chat: %{id: chat_id}}}, state) do
    case Regex.match?(@ping_regex, text) do
      true -> Nadia.send_message(chat_id, "Pong !")
      false -> IO.inspect text
    end
    
    {:noreply, state}
  end

end
