defmodule HedwigDadJoke do
  @moduledoc """
  Documentation for HedwigDadJoke.
  """
  use GenServer

  alias HedwigDadJoke.{
    Config,
    MessageFormatter
  }

  @name __MODULE__

  def start_link(config \\ %{}) do
    GenServer.start_link(@name, config, name: @name)
  end

  def random do
    GenServer.call(@name, :random)
  end

  @impl true
  def init(options) do
    {:ok, Config.new(options)}
  end

  @impl true
  def handle_call(:random, _from, %{sources: sources} = state) do
    source = Enum.random(sources)

    {:ok, reply} =
      state
      |> source.client()
      |> source.random()
      |> MessageFormatter.format(source)

    {:reply, reply, state}
  end
end
