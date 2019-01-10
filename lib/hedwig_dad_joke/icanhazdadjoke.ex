defmodule HedwigDadJoke.Icanhazdadjoke do
  def random(client) do
    Tesla.get(client, "")
  end

  def client do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://icanhazdadjoke.com/"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"User-Agent", "hedwig_dad_joke"},
         {"Accept", "application/json"}
       ]}
    ]

    Tesla.client(middleware)
  end
end
