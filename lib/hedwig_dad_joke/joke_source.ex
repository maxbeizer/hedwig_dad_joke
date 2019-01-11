defmodule HedwigDadJoke.JokeSource do
  @moduledoc """
  The behaviour for all sources of dad jokes.
  """
  @type status :: non_neg_integer()
  @type url :: String.t()
  @type body :: %{id: String.t(), joke: String.t()}
  @type api_response :: {atom(), %{status: status(), url: url(), body: body()}}
  @type message :: {atom(), String.t()}

  @callback random(term()) :: {:error, any()} | {:ok, term()}
  @callback client(HedwigDadJoke.Config.t()) :: term()
  @callback format(api_response(), HedwigDadJoke.Config.t()) :: message()
end
