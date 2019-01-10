defmodule HedwigDadJoke do
  @moduledoc """
  Documentation for HedwigDadJoke.
  """
  use GenServer
  alias HedwigDadJoke.{
    Icanhazdadjoke,
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
  def init(config) do
    config =
      config
      |> Map.put_new(:client, Icanhazdadjoke.client(config))

    {:ok, config}
  end

  @impl true
  def handle_call(:random, _from, %{client: client} = state) do
    {:ok, reply} =
      client
      |> Icanhazdadjoke.random()
      |> MessageFormatter.format()

    {:reply, reply, state}
  end
end
