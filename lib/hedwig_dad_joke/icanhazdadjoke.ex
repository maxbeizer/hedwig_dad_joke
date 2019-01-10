defmodule HedwigDadJoke.Icanhazdadjoke do
  @default_user_agent "https://github.com/maxbeizer/hedwig_dad_joke"
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
