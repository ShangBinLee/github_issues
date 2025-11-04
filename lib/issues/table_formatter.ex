defmodule Issues.TableFormatter do
  @moduledoc """
  データをテーブル形式の表現に変換、出力するモジュール
  """

  @doc """
  データから指定したヘッダーに対応するカラムを抽出し\s\s
  テーブル形式で一行ずつ出力する。

  ## パラメータ

    - rows：カラムを抽出するデータ、issuesに該当する。
    - headers：抽出するカラム名のリスト\s\s
      issuesのフィールド名がカラム名に該当する。

  """
  @spec print_table_for_columns(list(Map), list(String.t())) :: :ok
  def print_table_for_columns(rows, headers) do
    with columns = split_into_columns(rows, headers),
      columns_widths = widths_of(headers_printable(headers), columns),
      format = format_for(columns_widths)
    do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(columns_widths))
      puts_in_columns(columns, format)
    end
  end

  @doc """
  行のリストをヘッダーに対応するカラムのリストに変換する。

  ## 戻り値

    columns：カラムのリスト、各カラム内では行順にデータが並んでいる。

  ## 例

      iex> [
      ...>  %{d1: 1, d2: 2, d3: 3}, # 行1
      ...>  %{d1: 4, d2: 5, d3: 6}  # 行2
      ...> ]
      ...> |> Issues.TableFormatter.split_into_columns([:d1, :d3])
      [
        ["1", "4"], # 列1
        ["3", "6"]  # 列3
      ]

  """
  @spec split_into_columns(list(Map), list(String.t())) :: list(list(String.t()))
  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows do
        printable(row[header])
      end
    end
  end

  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  def headers_printable(headers), do: headers |> Enum.map(&printable/1)

  @doc """
  カラム名のリストとカラムのリストからカラムごとの幅を返す。

  ## 例

      iex> Issues.TableFormatter.widths_of(
      ...>  ["number", "title"],
      ...>  [
      ...>    ["1", "2", "3"],
      ...>    ["text", "dd", "general"]
      ...>  ])
      [6, 7]
      iex> Issues.TableFormatter.widths_of(
      ...>  ["country", "product"],
      ...>  [
      ...>    ["jp", "us", "eu"],
      ...>    ["小麦粉", "麦わら帽子", "ジーンズ"]
      ...>  ])
      [7, 7]

  """
  @spec widths_of(list(String.t()), list(Enumerable.t(String.t()))) :: list(integer())
  def widths_of(headers, columns) do
    Enum.zip(
      widths_of_headers(headers),
      widths_of_columns(columns)
    )
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.max/1)
  end

  @spec widths_of_headers(list(String.t())) :: list(integer())
  defp widths_of_headers(headers) do
    headers |> Enum.map(&String.length/1)
  end
  @spec widths_of_columns(list(Enumerable.t(String.t()))) :: list(integer())
  defp widths_of_columns(columns) do
    for column <- columns do
      column |> Enum.map(&String.length/1) |> Enum.max()
    end
  end

  @doc """
  カラムごとの幅に合わせて行の出力フォーマットを返す。

  ## パラメータ

    - column_widths：カラムの幅のリスト

  ## 例

      iex> Issues.TableFormatter.format_for([1, 2, 3])
      "~-1ts | ~-2ts | ~-3ts~n"
      iex> Issues.TableFormatter.format_for([1, 2, 3])
      ...> |> :io.format(["子", "子ど", "子ども"])
      :ok # 子 | 子ど | 子ども\n

  """
  @spec format_for(Enumerable.t(integer())) :: :io.format()
  def format_for(column_widths) do
    column_widths
    |> Enum.map_join(" | ", fn width -> "~-#{width}ts" end)
    |> (&(&1 <> "~n")).()
  end

  @doc """
  テーブルヘッド(head)とテーブルボディ(body)の区切り行を返す。\s\s
  カラムごとの幅に合わせて行う。

  ## パラメータ

    - column_widths：カラムの幅のリスト

  ## 例

      iex> Issues.TableFormatter.separator([1, 2, 3])
      "--+----+----"

  """
  @spec separator(Enumerable.t(integer())) :: String.t()
  def separator(columns_widths) do
    columns_widths
    |> Enum.map_join("-+-", fn width -> String.duplicate("-", width) end)
  end

  @doc """
  カラムのリストを行のリストに変換し、指定したフォーマットで一行ずつ出力する

  ## パラメータ

    - columns：カラムのリスト
    - format：行の出力フォーマット

  """
  @spec puts_in_columns(list(Enumerable.t(String.t())), :io.format()) :: :ok
  def puts_in_columns(columns, format) do
    columns
    |> Enum.zip() # 行のリストに変換-1
    |> Enum.map(&Tuple.to_list/1) # 行のリストに変換-2
    |> Enum.each(fn row -> puts_one_line_in_columns(row, format) end)
  end

  @doc """
  一行を指定したフォーマットで出力する。

  ## パラメータ

    - row：出力する行
    - format：行の出力フォーマット

  """
  @spec puts_one_line_in_columns(list(String.t()), :io.format()) :: :ok
  def puts_one_line_in_columns(row, format) do
    :io.format(format, row)
  end
end
