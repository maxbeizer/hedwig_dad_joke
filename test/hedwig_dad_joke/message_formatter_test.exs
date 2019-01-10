defmodule HedwigDadJoke.MessageFormatterTest do
  use ExUnit.Case

  alias HedwigDadJoke.MessageFormatter

  describe "format/1" do
    test ~S"""
    when status is 200 and body is proper shape, build a string of the joke,
    a newline and the link to the joke
    """ do
      url = "https://foobar.com/"
      id = "test-id"

      api_response =
        {:ok,
         %{status: 200, url: url, body: %{"id" => id, "joke" => "test joke", "status" => 200}}}

      {:ok, result} = MessageFormatter.format(api_response)
      assert "test joke\n#{url}/j/#{id}" == result
    end
  end
end
