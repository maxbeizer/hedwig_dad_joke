defmodule HedwigDadJoke.Icanhazdadjoke do
  @moduledoc """
  The module to use icanhazdadjoke.com as the source of jokes.
  """
  alias HedwigDadJoke.JokeSource
  @behaviour JokeSource
  @base_url "https://icanhazdadjoke.com/"

  @impl JokeSource
  def random(client) do
    Tesla.get(client, "")
  end

  @impl JokeSource
  def client(config) do
    middleware = [
      {Tesla.Middleware.BaseUrl, @base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"User-Agent", Map.get(config, :user_agent)},
         {"Accept", "application/json"}
       ]}
    ]

    Tesla.client(middleware)
  end

  @doc """
  Given an API response, format the data into a message to display the joke
  and a link for attribution.
  """
  @impl JokeSource
  def format({:ok, %{status: 200, url: url, body: %{"id" => id, "joke" => joke}}}, %{
        format: :plain
      }) do
    {:ok, joke <> "\n" <> url <> "/j/" <> id}
  end

  def format({:ok, %{status: 200}}, %{format: format}),
    do: {:ok, "Ouch! I don't know how to format a response as: #{format}"}

  def format({:ok, %{status: status}}, _), do: unhandled_status(status)
  def format({:error, %{status: status}}, _), do: unhandled_status(status)

  defp unhandled_status(status), do: {:ok, "Oops! Error: #{status} response"}
end
