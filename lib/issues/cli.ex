defmodule Issues.CLI do
  @moduledoc """
  コマンド入力をパースし、対象のGithubプロジェクトで

  一番古いn個のissueを表示する。
  """

  @default_count 4
  def run(argv) do
    argv
    |> parse_args()
    |> process()
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

  @doc """

  パースされたコマンド入力を実行する。

  ## パラメータ

    - コマンド
      - `:help`
      - `{ユーザ名、プロジェクト名、項目数}

  """
  def process(:help) do
    IO.puts """
    コマンド形式：issues <ユーザ名> <プロジェクト名> [ 項目数 | #{@default_count}（デフォルト値） ]
    """
    System.halt(0)
  end
  def process({user, project, _count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    IO.puts """
    GithubのIssue取得に失敗しました。
    エラー内容：#{error}
    """
    System.halt(2)
  end
end
