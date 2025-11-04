# github_issues
Githubのissuesに関するプロジェクト

## 機能概要

### Github Issueの取得

対象プロジェクトから最新のIssueを指定した項目数だけ取得し、テーブル形式で古い順に表示する。

## Github Issueの取得（項目数指定無し）
### mix run -e

#### 実行
```
$ mix run -e 'Issues.CLI.main(["elixir-lang", "elixir"])'
```

#### 結果
```
number | created_at           | title
-------+----------------------+-------------------------------------------------------------------------------------
14837  | 2025-10-17T07:51:35Z | Dialyzer errors after upgrading to 1.19.0
14873  | 2025-10-29T19:35:59Z | No longer able to format specific files with compile error present in different file
14875  | 2025-10-30T03:23:42Z | Parallel rebar3 dependency compilation fails with deeper build paths
14883  | 2025-10-31T11:20:37Z | Add Integer.to_float/1
```

### mix run --eval

#### 実行
```
$ mix run --eval 'Issues.CLI.main(["elixir-lang", "elixir"])'
```

#### 結果
```
number | created_at           | title
-------+----------------------+-------------------------------------------------------------------------------------
14837  | 2025-10-17T07:51:35Z | Dialyzer errors after upgrading to 1.19.0
14873  | 2025-10-29T19:35:59Z | No longer able to format specific files with compile error present in different file
14875  | 2025-10-30T03:23:42Z | Parallel rebar3 dependency compilation fails with deeper build paths
14883  | 2025-10-31T11:20:37Z | Add Integer.to_float/1
```

### IEx

#### 実行（CMD内）
```
$ iex -S mix
```
上記でIExを実行すると

#### 実行（IEx内）
```elixir
iex(1)> Issues.CLI.main(["elixir-lang", "elixir"])
```

#### 結果
```elixir
number | created_at           | title
-------+----------------------+-------------------------------------------------------------------------------------
14837  | 2025-10-17T07:51:35Z | Dialyzer errors after upgrading to 1.19.0
14873  | 2025-10-29T19:35:59Z | No longer able to format specific files with compile error present in different file
14875  | 2025-10-30T03:23:42Z | Parallel rebar3 dependency compilation fails with deeper build paths
14883  | 2025-10-31T11:20:37Z | Add Integer.to_float/1
:ok
```

### escript

#### escriptビルド
```
$ mix escript.build
```

#### 実行（プロジェクトルート上で）
```
$ ./github_issues elixir-lang elixir
```

#### 結果
```
number | created_at           | title
-------+----------------------+-------------------------------------------------------------------------------------
14837  | 2025-10-17T07:51:35Z | Dialyzer errors after upgrading to 1.19.0
14873  | 2025-10-29T19:35:59Z | No longer able to format specific files with compile error present in different file
14875  | 2025-10-30T03:23:42Z | Parallel rebar3 dependency compilation fails with deeper build paths
14883  | 2025-10-31T11:20:37Z | Add Integer.to_float/1
```

## Github Issueの取得（項目数指定）
### mix run -e

#### 実行
```
$ mix run -e 'Issues.CLI.main(["elixir-lang", "elixir", "10"])'
```

#### 結果
```
number | created_at           | title
-------+----------------------+-------------------------------------------------------------------------------------
14377  | 2025-03-28T10:18:24Z | Upcoming type-related deprecations
14401  | 2025-04-05T08:43:36Z | Misleading unused clause warning on 1.20-dev
14558  | 2025-06-06T06:55:19Z | Set-theoretic types: inference of all language constructs
14623  | 2025-07-04T13:15:55Z | ex_unit: Add :capture_io tag
14789  | 2025-09-24T21:03:25Z | Unused require, as: warning suggest alias
14831  | 2025-10-13T18:20:21Z | Support Erlang/OTP 29 new features
14837  | 2025-10-17T07:51:35Z | Dialyzer errors after upgrading to 1.19.0
14873  | 2025-10-29T19:35:59Z | No longer able to format specific files with compile error present in different file
14875  | 2025-10-30T03:23:42Z | Parallel rebar3 dependency compilation fails with deeper build paths
14883  | 2025-10-31T11:20:37Z | Add Integer.to_float/1
```

### mix run --eval

#### 実行
```
$ mix run --eval 'Issues.CLI.main(["elixir-lang", "elixir", "10"])'
```

#### 結果
```
number | created_at           | title
-------+----------------------+-------------------------------------------------------------------------------------
14377  | 2025-03-28T10:18:24Z | Upcoming type-related deprecations
14401  | 2025-04-05T08:43:36Z | Misleading unused clause warning on 1.20-dev
14558  | 2025-06-06T06:55:19Z | Set-theoretic types: inference of all language constructs
14623  | 2025-07-04T13:15:55Z | ex_unit: Add :capture_io tag
14789  | 2025-09-24T21:03:25Z | Unused require, as: warning suggest alias
14831  | 2025-10-13T18:20:21Z | Support Erlang/OTP 29 new features
14837  | 2025-10-17T07:51:35Z | Dialyzer errors after upgrading to 1.19.0
14873  | 2025-10-29T19:35:59Z | No longer able to format specific files with compile error present in different file
14875  | 2025-10-30T03:23:42Z | Parallel rebar3 dependency compilation fails with deeper build paths
14883  | 2025-10-31T11:20:37Z | Add Integer.to_float/1
```

### IEx

#### 実行（CMD内）
上記と同じ

#### 実行（IEx内）
```elixir
iex(1)> Issues.CLI.main(["elixir-lang", "elixir", "10"])
```

#### 結果
```elixir
number | created_at           | title
-------+----------------------+-------------------------------------------------------------------------------------
14377  | 2025-03-28T10:18:24Z | Upcoming type-related deprecations
14401  | 2025-04-05T08:43:36Z | Misleading unused clause warning on 1.20-dev
14558  | 2025-06-06T06:55:19Z | Set-theoretic types: inference of all language constructs
14623  | 2025-07-04T13:15:55Z | ex_unit: Add :capture_io tag
14789  | 2025-09-24T21:03:25Z | Unused require, as: warning suggest alias
14831  | 2025-10-13T18:20:21Z | Support Erlang/OTP 29 new features
14837  | 2025-10-17T07:51:35Z | Dialyzer errors after upgrading to 1.19.0
14873  | 2025-10-29T19:35:59Z | No longer able to format specific files with compile error present in different file
14875  | 2025-10-30T03:23:42Z | Parallel rebar3 dependency compilation fails with deeper build paths
14883  | 2025-10-31T11:20:37Z | Add Integer.to_float/1
:ok
```

### escript

#### escriptビルド
上記と同じ

#### 実行（プロジェクトルート上で）
```
$ ./github_issues elixir-lang elixir 10
```

#### 結果
```
number | created_at           | title
-------+----------------------+-------------------------------------------------------------------------------------
14377  | 2025-03-28T10:18:24Z | Upcoming type-related deprecations
14401  | 2025-04-05T08:43:36Z | Misleading unused clause warning on 1.20-dev
14558  | 2025-06-06T06:55:19Z | Set-theoretic types: inference of all language constructs
14623  | 2025-07-04T13:15:55Z | ex_unit: Add :capture_io tag
14789  | 2025-09-24T21:03:25Z | Unused require, as: warning suggest alias
14831  | 2025-10-13T18:20:21Z | Support Erlang/OTP 29 new features
14837  | 2025-10-17T07:51:35Z | Dialyzer errors after upgrading to 1.19.0
14873  | 2025-10-29T19:35:59Z | No longer able to format specific files with compile error present in different file
14875  | 2025-10-30T03:23:42Z | Parallel rebar3 dependency compilation fails with deeper build paths
14883  | 2025-10-31T11:20:37Z | Add Integer.to_float/1
```

## ドキュメント化
### ExDoc
#### 実行（CMD内）
```
$ mix docs
```

#### 結果
```
Generating docs...
View "html" docs at "doc/index.html"
View "epub" docs at "doc/GithubIssues.epub"
```

#### 確認
作成された`doc/index.html`をブラウザで開いて確認する。
