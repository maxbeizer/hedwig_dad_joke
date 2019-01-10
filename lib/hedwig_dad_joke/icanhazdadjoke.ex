defmodule HedwigDadJoke.Icanhazdadjoke do
  @moduledoc """
  The module to use icanhazdadjoke.com as the source of jokes.
  """

  @base_url "https://icanhazdadjoke.com/"

  def random(client) do
    Tesla.get(client, "")
  end

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
end
