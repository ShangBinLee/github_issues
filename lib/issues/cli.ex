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
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  # ユーザ名、プロジェクト名、項目数
  def args_to_internal_representation([user, project, count]) do
    {user, project, String.to_integer(count)}
  end
  # ユーザ名、プロジェクト名
  def args_to_internal_representation([user, project]) do
    {user, project, @default_count}
  end
  # その他
  def args_to_internal_representation(_) do
    :help
  end
end
