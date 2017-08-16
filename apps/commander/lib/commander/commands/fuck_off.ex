defmodule Commander.Commands.FuckOff do
  use GenServer

  @messages [
    "Fuck off !",
    "Серьезно ? Я похож на того, кто понимает обезьяний ?",
    "Да иди ты нахер..."
  ]

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def handle(%{reply_to: pid} = message) do
    GenServer.cast(pid, {:reply_text, Enum.random(@messages), message})
  end

  def handle(_), do: :ok
end
