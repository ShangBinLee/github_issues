defmodule Issues.GithubIssues do
  @moduledoc """
  Github Issuesに関するモジュール

  公開プロジェクトのIssuesを照会する
  """

  @github_url Application.compile_env(:github_issues, :github_url)

  @doc """
  コマンド入力に該当するプロジェクトのissuesを取得
  """
  def fetch(user, project) do
    issues_url(user, project)
    |> Req.get!()
    |> handle_response()
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response(%Req.Response{status: 200, body: body}) do
    {:ok, body}
  end

  def handle_response(%Req.Response{status: _, body: body}) do
    {:error, body}
  end
end
