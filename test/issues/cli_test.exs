defmodule Issues.CLITest do
  use ExUnit.Case
  doctest Issues.CLI

  import Issues.CLI, only: [parse_args: 1]

  test "オプション-hや--helpを受け取ると:helpに返却する" do
    assert parse_args(["-h", "anything"]) === :help
    assert parse_args(["--help", "anything"]) === :help
  end

  test "ユーザ名、プロジェクト名、項目数をパースして、返却する" do
    assert parse_args(["elixir-lang", "elixir", "99"]) === {"elixir-lang", "elixir", 99}
  end

  test "ユーザ名、プロジェクト名をパースして、デフォルト項目数を含めて返却する" do
    assert parse_args(["elixir-lang", "elixir"]) === {"elixir-lang", "elixir", 4}
  end
end
