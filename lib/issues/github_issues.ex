defmodule Issues.GithubIssues do
  @moduledoc """
  Github Issuesに関するモジュール

  公開プロジェクトのIssuesを照会する
  """
  require Logger

  @github_url Application.compile_env(:github_issues, :github_url)

  @doc """
  コマンド入力に該当するプロジェクトのissuesを取得
  """
  def fetch(user, project) do
    Logger.info("ユーザ#{user}のプロジェクト#{project}のissuesを取得")

    issues_url(user, project)
    |> Req.get!()
    |> handle_response()
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response(%Req.Response{status: status, body: body}) do
    Logger.info("レスポンス情報： ステータスコード=#{status}")
    Logger.debug(fn -> inspect(body) end)
    {
      check_for_error(status),
      body
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
