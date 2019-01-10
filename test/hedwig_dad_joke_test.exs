defmodule HedwigDadJokeTest do
  use ExUnit.Case
  doctest HedwigDadJoke

  test "greets the world" do
    assert HedwigDadJoke.hello() == :world
  end
end
