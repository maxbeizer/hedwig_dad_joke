defmodule HedwigDadJoke.MixProject do
  use Mix.Project

  def project do
    [
      app: :hedwig_dad_joke,
      version: "1.1.2",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      description: "A plugin for Hedwig that will make your eyes roll",
      package: [
        name: "hedwig_dad_joke",
        files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/maxbeizer/hedwig_dad_joke"}
      ],
      source_url: "https://github.com/maxbeizer/hedwig_dad_joke",
      homepage_url: "https://github.com/maxbeizer/hedwig_dad_joke"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:hackney, "~> 1.14.0"},
      {:hedwig, "~> 1.0"},
      {:jason, ">= 1.0.0"},
      {:tesla, "~> 1.2.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
