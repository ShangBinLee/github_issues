defmodule Issues.CLI do
  @moduledoc """
  コマンド入力をパースし、対象のGithubプロジェクトで

  一番古いn個のissueを表示する。
  """

  @default_count 4
  def run(argv) do
    parse_args(argv)
  end

  @doc """

  コマンド入力をパースする。

  ## パラメータ

    - argv
      - `-h`または`--help`
      - （必須）ユーザ名、（必須）プロジェクト名、（オプション）項目数

  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _}
        -> :help
      {_, [user, project, count], _}
        -> {user, project, String.to_integer(count)}
      {_, [user, project], _}
        -> {user, project, @default_count}
      _ -> :help
    end
  end
end
