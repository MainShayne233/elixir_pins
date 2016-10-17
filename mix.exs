defmodule ElixirPins.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_pins,
      version: "0.0.1",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      description: description,
      package: package
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:sshex, "2.1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    Elixir interface for Raspberry Pi GPIO pins.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :elixir_pins,
     files: ["lib", "mix.exs", "README*"],
     maintainers: ["MainShayne233"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/MainShayne233/elixir_pins"}]
  end

end
