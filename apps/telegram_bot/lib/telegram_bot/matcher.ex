defmodule TelegramBot.Matcher do
  use GenServer
  alias TelegramBot.Handler
  alias Nadia.Model.{Message, Voice}

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, []}
  end


  def handle_cast({:message, %Message{voice: %Voice{}} = message}, state) do
    Handler.Voice.handle(message)
    {:noreply, state}
  end

  def handle_cast({:message, %Message{text: text} = message}, state) when is_binary(text) do
    Handler.Text.handle(message)
    {:noreply, state}
  end

  def handle_cast({:message, message}, state) do
    IO.inspect message
    {:noreply, state}
  end

  def handle_cast({:other, message}, state) do

    {:noreply, state}
  end

  def match(%{message: %Message{} = message}) do
    GenServer.cast(__MODULE__, {:message, message})
  end

  def match(message) do
    GenServer.cast(__MODULE__, {:other, message})
  end
end
