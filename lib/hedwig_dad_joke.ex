defmodule HedwigDadJoke do
  @moduledoc """
  The module housing the functionality to fetch and format jokes from a
  variety of sources.
  """
  use GenServer
  @behaviour JokeModule

  alias HedwigDadJoke.Config

  @name __MODULE__

  @doc false
  @spec start_link(map()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(config \\ %{}) do
    GenServer.start_link(@name, config, name: @name)
  end

  @doc """
  Fetch a dadjoke from one of our sources and format it in the style detailed
  in the config.
  """
  @impl JokeModule
  def random do
    if Process.whereis(@name) do
      GenServer.call(@name, :random)
    else
      get_random()
    end
  end

  @impl true
  @spec init(map()) :: {:ok, Config.t()}
  def init(options) do
    {:ok, Config.new(options)}
  end

  @impl true
  @spec handle_call(atom(), any(), Config.t()) :: {:reply, String.t(), Config.t()}
  def handle_call(:random, _from, state) do
    {:ok, reply} = get_random(state)

    {:reply, reply, state}
  end

  # When gen_server is running, use state as config
  defp get_random(%{sources: sources} = state) do
    source = Enum.random(sources)

    state
    |> source.client()
    |> source.random()
    |> source.format(state)
  end

  # When no gen_server is running, just go get the joke
  defp get_random do
    %{sources: sources} = state = Config.new()
    source = Enum.random(sources)

    {:ok, reply} =
      state
      |> source.client()
      |> source.random()
      |> source.format(state)

    reply
  end
end
