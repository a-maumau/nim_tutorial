# 文字列
echo "これは文字列\tタブとかの\\とかによる制御が\n可能である\n"
echo """ダブルクォーテーションを三つ繋げたやつで囲めば
改行含んだ文字列を作ることができる。
"""
# htmlのソースを含めたりするのに便利？
echo r"raw文字列リテラルの中のでは\はエスケープ文字にはならなないのです\n"

# 変数
# 変数宣言はvarによってできる
var x,y = 0 # x = ３, y = 3 となることに注意
# 型を指定することもできる
var a,b : int

# これはエラー
#型が決まらないといけない
# var x

# これもエラー, Pythonじゃないので静的型付けです。
# x = 0.05

# 一気に宣言も可能
var
  # インデントはスペースでないといけない。
  # 公式的には2つスペースが推奨のようである？　一応コンパイルは４スペースでも通る。
  w = 0
  n,m : int
  str : string

# 今の所代入演算子のオーバーロードはできないそう

# 初期化をしない場合、数値は０にstringはnilになる模様
echo "初期化してない変数"
echo "m ", m
echo "n ", n
echo "str", str
echo "a,b ", a,b
# $を演算子の前につけけて文字列にする必要があるがechoは勝手にやってくれる。
str = $m
echo "$ ", $str

# 数字
# みやすいように　"_"を使った数字のク区切りを行うことができる。
var num = 1_000_000
# pythonとかでのeを使った表現も可能。
var bili = 1.0e9
# 17歳(16真数)
var hex = 0x17
# 17歳(8進数)
var oct = 0o17 # ”ゼロ”と”英語の小文字o”
# 17歳(2進数)
var bin = 0b10001 # ”ゼロ”と”英語の小文字b”

echo "\n数たち"
echo "num ", num
echo "bili ", bili
echo "hex ", hex
echo "oct ", oct
echo "bin ", bin

# 定数
# constはコンパイル時点で埋め込まれる
const c = "this is const"

# var 同様
const
    con = 0
    ss = "string!"
# というようにできる

# エラー。代入はできない。
# ss = "ddd"

# 初期値を与えないのもエラー
# const cons: int

# 計算は当然可能
var q = con+2
echo "\nq ", q

# let文
let l = "人類よこれがletだ。"

# エラー
# l = "書き換えできない"

# 初期値与えないのもエラー
# let ll : int

# const と let の違い
# readLine(stdin)は端末からの入力を受け取る関数
# 改行したくないとき
stdout.write "入力を : "
# エラー
#const input = readLine(stdin)
# 動く
let input = readLine(stdin)

#[
大きな違いはコンパイル時の時に決められるか、決められないかという点。
constはコンパイルの時点で埋め込まれるが、
letは実行時に初期化される。

どちらも共通しているのは値を変更しようとすることはできないということ。
]#