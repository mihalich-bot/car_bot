defmodule DiscordBot do
  @moduledoc """
  Documentation for DiscordBot.
  """

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end
end
