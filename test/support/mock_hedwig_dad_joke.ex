defmodule MockHedwigDadJoke do
  @moduledoc """
  Mock to help test joke functionality.
  """
  @behaviour JokeModule

  @impl JokeModule
  def random do
    "test joke from MockHedwigDadJoke"
  end
end
