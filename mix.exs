defmodule GithubIssues.MixProject do
  use Mix.Project

  def project do
    [
      app: :github_issues,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "GithubIssues",
      source_url: "https://github.com/ShangBinLee/github_issues",
      homepage_url: "https://github.com/ShangBinLee/github_issues",
      docs: docs(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :observer, :wx, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:req, "~> 0.5.0"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false, warn_if_outdated: true},
    ]
  end

  defp escript_config do
    [
      main_module: Issues.CLI,
    ]
  end

  defp docs do
    [
      main: "Issues.CLI",
      extras: ["README.md"]
    ]
  end
end
