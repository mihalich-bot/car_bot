defmodule TelegramBot.Poller do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    update()
    {:ok, 0}
  end

  def update do
    :timer.sleep(5000)
    GenServer.cast(__MODULE__, :update)
  end

  def handle_cast(:update, offset) do
    new_offset = Nadia.get_updates([offset: offset])
                 |> process_messages()

    {:noreply, new_offset + 1, 100}
  end

  def handle_info(:timeout, offset) do
    update()
    {:noreply, offset}
  end

  # Helpers

  defp process_messages({:ok, []}), do: -1
  defp process_messages({:ok, results}) do
    results
    |> Enum.map(fn %{update_id: id} = message ->
      message
      |> process_message

      id
    end)
    |> List.last
  end
  # defp process_messages({:error, %Nadia.Model.Error{reason: reason}}) do
  #   Logger.log :error, reason
  #
  #   -1
  # end
  defp process_messages({:error, error}) do
    IO.inspect error
    -1
  end

  defp process_messages(data) do
    IO.inspect data
  end

  defp process_message(nil), do: IO.puts "nil"
  defp process_message(message) do
    try do
      TelegramBot.Matcher.match(message)
    rescue
      err ->
        Logger.log :warn, "Errored with #{err} at #{Poison.encode! message}"
    end
  end
end
