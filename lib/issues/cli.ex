defmodule Issues.CLI do
  @moduledoc """
  コマンド入力をパースし、対象のGithubプロジェクトで

  最新のn個のissueを古い順に表示する。
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
  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_descending_order() # 新しい順に並べ替える
    |> last(count) # `count`個を取り出し、古い順にする
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    IO.puts """
    GithubのIssue取得に失敗しました。
    エラー内容：#{error}
    """
    System.halt(2)
  end

  def sort_into_descending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(&(&1["created_at"] >= &2["created_at"]))
  end

  @doc """
  リストから最初の`count`個の要素を取り出し、逆順に並べ替える
  """
  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end
end
