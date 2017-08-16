defmodule Commander.Commands.Ping do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def handle(%{reply_to: pid} = message) do
    GenServer.cast(pid, {:reply_text, "Pong !", message})
  end

  def handle(_), do: :ok
end
