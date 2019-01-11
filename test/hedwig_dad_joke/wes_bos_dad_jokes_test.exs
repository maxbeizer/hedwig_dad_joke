defmodule HedwigDadJoke.WesBosDadJokesTest do
  use ExUnit.Case

  alias HedwigDadJoke.WesBosDadJokes

  describe "format/2" do
    test ~S"""
    when status is 200 and body is proper shape, build a string of the joke,
    a newline and the link to the joke
    """ do
      url = "https://foobar.com/"

      api_response =
        {:ok,
         %{
           status: 200,
           url: url,
           body: ~S"""
           # Dad style programming jokes

           submit your own, if they make me laugh I'll merge them.

           ---

           **Q:**  What diet did the ghost developer go on?

           **A:** Boolean

           ---
           """
         }}

      {:ok, result} = WesBosDadJokes.format(api_response, %{format: :plain})

      expected =
        "What diet did the ghost developer go on? Boolean\n" <>
          "https://github.com/wesbos/dad-jokes/blob/master/readme.md"

      assert expected == result
    end

    test ~S"""
    when the API returns a status other than 200, return an error message
    """ do
      api_response = {:ok, %{status: 418, url: "not-so-funny.com", body: ""}}
      {:ok, result} = WesBosDadJokes.format(api_response, %{format: :plain})
      assert "Oops! Error: 418 response" == result
    end

    test ~S"""
    when the API returns an error tuple, return an error message
    """ do
      api_response = {:error, %{status: 500, url: "ouch.com", body: ""}}
      {:ok, result} = WesBosDadJokes.format(api_response, %{format: :plain})
      assert "Oops! Error: 500 response" == result
    end

    test ~S"""
    when the format is unkown to us, return an error message
    """ do
      api_response = {:ok, %{status: 200, url: "ouch.com", body: ""}}
      {:ok, result} = WesBosDadJokes.format(api_response, %{format: "some_unkown_format"})

      expected = "Ouch! I don't know how to format a response as: some_unkown_format"

      assert expected == result
    end
  end
end
