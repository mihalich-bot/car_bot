defmodule Commander do
  use GenServer
  require Logger
  alias Commander.Model.Command

  @moduledoc """
  Documentation for Commander.
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def handle_cast({:fuck_off, command}, state) do
    Commander.Commands.FuckOff.handle(command)
    {:noreply, state}
  end

  def handle_cast(any, state) do
    {:noreply, state}
  end

  def handle({:command, %Command{command: command} = cmd}) do
    GenServer.cast(__MODULE__, {command, cmd})
  end

  def handle(any) do
    GenServer.cast(__MODULE__, any)
  end
end
