defmodule HedwigDadJoke.RespondersTest do
  @moduledoc false
  use HedwigDadJoke.RobotCase, responders: [{HedwigDadJoke.Responders, []}]

  test "dadjoke", %{adapter: adapter, msg: msg} do
    send(adapter, {:message, %{msg | text: "hedwig dadjoke"}})
    assert_receive {:message, %{text: text}}

    assert "test joke from MockHedwigDadJoke" == text
  end

  test "dad joke", %{adapter: adapter, msg: msg} do
    send(adapter, {:message, %{msg | text: "hedwig dad joke"}})
    assert_receive {:message, %{text: text}}

    assert "test joke from MockHedwigDadJoke" == text
  end

  test "dadjoke me", %{adapter: adapter, msg: msg} do
    send(adapter, {:message, %{msg | text: "hedwig dadjoke me"}})
    assert_receive {:message, %{text: text}}

    assert "test joke from MockHedwigDadJoke" == text
  end

  test "dad joke me", %{adapter: adapter, msg: msg} do
    send(adapter, {:message, %{msg | text: "hedwig dad joke me"}})
    assert_receive {:message, %{text: text}}

    assert "test joke from MockHedwigDadJoke" == text
  end
end
