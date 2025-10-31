defmodule Issues.TableFormatterTest do
  use ExUnit.Case
  doctest Issues.TableFormatter

  import ExUnit.CaptureIO

  alias Issues.TableFormatter, as: TF

  @simple_test_data [
    [c1: "r1 c1", c2: "r1 c2", c3: "r1 c3", c4: "r1+++c4"], # 行1
    [c1: "r2 c1", c2: "r2 c2", c3: "r2 c3", c4: "r2 c4"],   # 行2
    [c1: "r3 c1", c2: "r3 c2", c3: "r3 c3", c4: "r3 c4"],   # 行3
    [c1: "r4 c1", c2: "r4++c2", c3: "r4 c3", c4: "r4 c4"]   # 行4
  ]
  @headers [:c1, :c2, :c4]

  def split_with_three_columns do
    TF.split_into_columns(@simple_test_data, @headers)
  end

  test "データを列に分割する" do
    columns = split_with_three_columns()
    assert length(columns) == length(@headers)
    assert columns == [
      ["r1 c1", "r2 c1", "r3 c1", "r4 c1"],  # c1列
      ["r1 c2", "r2 c2", "r3 c2", "r4++c2"], # c2列
      ["r1+++c4", "r2 c4", "r3 c4", "r4 c4"] # c4列
    ]
  end

  test "列の幅" do
    widths = TF.widths_of(split_with_three_columns())
    assert widths == [5, 6, 7]
  end

  test "UTF-8対応フォーマット文字列の返却" do
    assert TF.format_for([9, 10, 11]) == "~-9ts | ~-10ts | ~-11ts~n"
  end

  test "フォーマットでUTF-8文字列の出力確認" do
    result = capture_io fn ->
      TF.format_for([1, 2, 3])
      |> :io.format(["子", "子ど", "子ども"])
    end

    assert result == "子 | 子ど | 子ども\n"
  end

  test "テーブル形式で出力確認(print_table_for_columns)" do
    result = capture_io fn ->
      TF.print_table_for_columns(@simple_test_data, @headers)
    end

    assert result == """
    c1    | c2     | c4\s\s\s\s\s
    ------+--------+--------
    r1 c1 | r1 c2  | r1+++c4
    r2 c1 | r2 c2  | r2 c4\s\s
    r3 c1 | r3 c2  | r3 c4\s\s
    r4 c1 | r4++c2 | r4 c4\s\s
    """
  end
end
