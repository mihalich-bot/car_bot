defmodule NlpProcessor do
  @moduledoc """
  Documentation for NlpProcessor.
  """

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, []}

  def process(params) do
    GenServer.cast(__MODULE__, {:query, params})
  end

  def handle_cast({:query, %{query: text, session_id: ssid} = query}, state) do
    case ElixirApiai.Query.query(text, ssid) do
      {:ok, result} -> handle_result(result, query)
      {:error, err} -> handle_error(err)
    end
    {:noreply, state}
  end

  defp handle_result(%{result: %{speech: text}}, %{reply_to: pid} = query) do
    GenServer.cast(pid, {:reply_text, text, query})
  end

  defp handle_result(%{result: result}, query) do
    IO.inspect result
  end

  defp handle_error(err) do
    IO.inspect err
  end
end
