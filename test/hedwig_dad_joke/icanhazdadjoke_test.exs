defmodule HedwigDadJoke.IcanhazdadjokeTest do
  use ExUnit.Case

  alias HedwigDadJoke.Icanhazdadjoke

  describe "format/2" do
    test ~S"""
    when status is 200 and body is proper shape, build a string of the joke,
    a newline and the link to the joke
    """ do
      url = "https://foobar.com/"
      id = "test-id"

      api_response =
        {:ok,
         %{status: 200, url: url, body: %{"id" => id, "joke" => "test joke", "status" => 200}}}

      {:ok, result} = Icanhazdadjoke.format(api_response, %{format: :plain})
      assert "test joke\n#{url}j/#{id}" == result
    end

    test ~S"""
    when the API returns a status other than 200, return an error message
    """ do
      api_response = {:ok, %{status: 418, url: "not-so-funny.com", body: %{}}}
      {:ok, result} = Icanhazdadjoke.format(api_response, %{format: :plain})
      assert "Oops! Error: 418 response" == result
    end

    test ~S"""
    when the API returns an error tuple, return an error message
    """ do
      api_response = {:error, %{status: 500, url: "ouch.com", body: %{}}}
      {:ok, result} = Icanhazdadjoke.format(api_response, %{format: :plain})
      assert "Oops! Error: 500 response" == result
    end

    test ~S"""
    when the format is unkown to us, return an error message
    """ do
      api_response = {:ok, %{status: 200, url: "ouch.com", body: %{}}}
      {:ok, result} = Icanhazdadjoke.format(api_response, %{format: "some_unkown_format"})

      expected = "Ouch! I don't know how to format a response as: some_unkown_format"

      assert expected == result
    end
  end
end
