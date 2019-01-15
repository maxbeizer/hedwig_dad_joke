defmodule HedwigDadJoke.Responders do
  @moduledoc """
  Responders for the dad joke plugin.
  """
  use Hedwig.Responder
  @joke_module Application.get_env(:hedwig_dad_joke, :joke_module, HedwigDadJoke)

  @usage """
  hedwig dad joke - Replies with a joke that will make your eyes roll
  """
  respond ~r/(dadjoke|dad joke)(\s*me)?$/iu, msg do
    response = @joke_module.random()
    send(msg, response)
  end
end
