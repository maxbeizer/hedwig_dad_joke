defmodule HedwigDadJoke.MessageFormatter do
  @moduledoc """
  When responses come in from data source(s), the MessageFormatter massages
  the data into a coherent string output for Hewig to respond with.
  """

  @type status :: non_neg_integer()
  @type url :: String.t()
  @type body :: %{id: String.t(), joke: String.t()}
  @type api_response :: {atom(), %{status: status(), url: url(), body: body()}}
  @type source :: module()
  @type message :: {atom(), String.t()}

  alias HedwigDadJoke.Icanhazdadjoke

  @doc """
  Given an API response, format the data into a message to display the joke
  and a link for attribution.
  """
  @spec format(api_response(), source()) :: message()
  def format({:ok, %{status: 200, url: url, body: %{"id" => id, "joke" => joke}}}, Icanhazdadjoke) do
    {:ok, joke <> "\n" <> url <> "/j/" <> id}
  end
  def format({:ok, %{status: 200}}, source), do: {:ok, "Ouch! I don't know how to format a response for the source: #{source}"}

  def format({:ok, %{status: status}}, _), do: unhandled_status(status)
  def format({:error, %{status: status}}, _), do: unhandled_status(status)

  defp unhandled_status(status), do: {:ok, "Oops! Error: #{status} response"}
end
