defmodule HedwigDadJoke do
  @moduledoc """
  Documentation for HedwigDadJoke.
  """
  use GenServer

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
      |> Map.put_new(:client, HedwigDadJoke.Icanhazdadjoke.client(config))

    {:ok, config}
  end

  @impl true
  def handle_call(:random, _from, %{client: client} = state) do
    {:ok, %{body: %{"joke" => joke}}} =
      client
      |> HedwigDadJoke.Icanhazdadjoke.random()

    {:reply, joke, state}
  end
end
