defmodule HedwigDadJoke.MessageFormatter do
  @moduledoc """
  When responses come in from data source(s), the MessageFormatter massages
  the data into a coherent string output for Hewig to respond with.
  """

  @type status :: non_neg_integer()
  @type url :: String.t()
  @type body :: %{id: String.t(), joke: String.t()}
  @type api_response :: {atom(), %{status: status(), url: url(), body: body()}}
  @type message :: {atom(), String.t()}

  @doc """
  Given an API response, format the data into a message to display the joke
  and a link for attribution.
  """
  @spec format(api_response()) :: message()
  def format({:ok, %{status: 200, url: url, body: %{"id" => id, "joke" => joke}}}) do
    {:ok, joke <> "\n" <> url <> "/j/" <> id}
  end
end
