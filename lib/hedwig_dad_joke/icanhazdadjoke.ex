defmodule HedwigDadJoke.Icanhazdadjoke do
  @default_user_agent "hedwig_dad_joke"

  def random(client) do
    Tesla.get(client, "")
  end

  def client(config) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://icanhazdadjoke.com/"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"User-Agent", Map.get(config, :user_agent, @default_user_agent)},
         {"Accept", "application/json"}
       ]}
    ]

    Tesla.client(middleware)
  end
end
