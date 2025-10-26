defmodule Issues.CLITest do
  use ExUnit.Case
  doctest Issues.CLI

  import Issues.CLI, only: [parse_args: 1, sort_into_descending_order: 1]

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

  test "降順に並べ替える" do
    result = ["c", "a", "b"]
    |> _fake_created_at_list()
    |> sort_into_descending_order()

    assert _extract_created_at(result) === ~w{c b a}
  end

  test "新しい順に並べ替える" do
    result = [
      "2025-10-17T07:51:35Z",
      "2025-10-17T07:43:35Z",
      "2025-10-13T18:20:21Z",
      "2025-10-19T13:53:28Z"
    ]
    |> _fake_created_at_list()
    |> sort_into_descending_order()

    assert _extract_created_at(result) === [
      "2025-10-19T13:53:28Z",
      "2025-10-17T07:51:35Z",
      "2025-10-17T07:43:35Z",
      "2025-10-13T18:20:21Z"
    ]
  end

  defp _fake_created_at_list(values) do
    for value <- values,
      do: %{"created_at" => value, "other_data" => "xxx"}
  end

  defp _extract_created_at(issues) do
    for issue <- issues, do: Map.get(issue, "created_at")
  end
end
