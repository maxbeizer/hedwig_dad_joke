defmodule JokeModule do
  @moduledoc """
  A behaviour to allow for mocking our joke providing modules.
  """

  @callback random() :: String.t()
end
