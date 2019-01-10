defmodule HedwigDadJoke.Config do
  @moduledoc """
  The home of the default configuration of HedwigDadJoke.
  """

  defstruct user_agent: "https://github.com/maxbeizer/hedwig_dad_joke",
            sources: [HedwigDadJoke.Icanhazdadjoke]

  @type t :: %__MODULE__{user_agent: String.t(), sources: [module()]}

  @doc """
  Merge the pased in configuration with the defaults to create the Config
  struct.
  """
  @spec new(map()) :: t()
  def new(passed_in) do
    struct(__MODULE__, passed_in)
  end
end
