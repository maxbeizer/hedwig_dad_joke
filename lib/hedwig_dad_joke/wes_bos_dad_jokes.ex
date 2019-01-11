defmodule HedwigDadJoke.WesBosDadJokes do
  @moduledoc """
  Dad jokes from https://github.com/wesbos/dad-jokes/
  """
  alias HedwigDadJoke.JokeSource
  @behaviour JokeSource

  # @base_url "https://api.github.com/repos/wesbos/dad-jokes/contents/readme.md"
  # /readme.md"
  # @base_url "https://api.github.com/repositories/23085269/contents/"
  @base_url "https://api.github.com/repos/wesbos/dad-jokes/contents"
  @repo_url "https://github.com/wesbos/dad-jokes/blob/master/readme.md"

  @impl JokeSource
  def random(client) do
    Tesla.get(client, "/readme.md?ref=master")
  end

  @impl JokeSource
  def client(config) do
    middleware = [
      {Tesla.Middleware.BaseUrl, @base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"User-Agent", Map.get(config, :user_agent)},
         {"Accept", "application/vnd.github.v3.raw+json"}
       ]}
    ]

    Tesla.client(middleware)
  end

  @impl JokeSource
  def format({:ok, %{status: 200, body: body}}, %{
        format: :plain
      }) do
    joke = do_format(body)
    {:ok, joke <> "\n" <> @repo_url}
  end

  def format({:ok, %{status: 200}}, %{format: format}),
    do: {:ok, "Ouch! I don't know how to format a response as: #{format}"}

  def format({:ok, %{status: status}}, _), do: unhandled_status(status)
  def format({:error, %{status: status}}, _), do: unhandled_status(status)

  defp unhandled_status(status), do: {:ok, "Oops! Error: #{status} response"}

  defp do_format(jokes) do
    jokes
    |> String.split("---")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&String.starts_with?(&1, "**Q"))
    |> Enum.random()
    |> String.replace("**Q:**", "")
    |> String.replace("**A:**", "")
    |> String.replace("\n", "")
    |> String.trim()
  end
end
