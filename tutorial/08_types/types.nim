# 型

# boolean
# あたいは 真 と 偽 をとる
var 
  t = true
  f = false
#[
演算に次いでは
  not, and, or, xor, <, <=, >, >=, !=, ==
また and, or式の評価は　短絡評価　つまり、左から評価していくというもの。
]#

# char
#[
Cのものとほぼ同義と思われる。
シングルクオートで囲んだ位置文字を指す。
必ず１バイトを表しているのでUTF-8のようなマルチバイト文字は表現できない
が、そのうちの一つのバイトになることはできる
演算子としては
  ==, <, <=, >, >=
とString(後述)に変換する
  $
を使うことができる。
]#

var ch = 'a'
# var ch2 = 'aa' #コンパイルエラー
# var ch3 = 'あ' #コンパイルエラー
echo ch
echo ord(ch) # char型の値を取り出す関数ord

if ch == 'a':
  echo "This is a a."

# String
# 文字列
#[
NimではCのように文字列(charの配列)のように終端文字が付いている。
終端文字へのアクセスへはエラーにはならない。
文字列の長さを返すメソッドlenには終端文字は含まれていない。
初期化のデフォルト値はnil
  nilは空文字列""とは別物。
pythonと違って変更可能
]#
var s: string = "this is "
echo s

# 長さを出す
echo(s.len())

# for文で１文字ずつ取り出せる。
for i in s:
  echo i

# 文字列の合成は & を使う。デフォルトだと+ではできない。
echo s & "String"

# addで足せる。
s.add("String")
echo s

var a: string = "文字列"
echo a
# UTF-8だと純粋に終端文字までの要素数を返しているようで長さが合わない
echo(a.len())

# unicodeモジュールを使う。便利らしい。
from unicode import runeLen
echo(a.runeLen())

# Pythonに比べてマルチバイト文字が怪しそうなので頑張ってほしい

# int
# 整数
#[
int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64
の型がある。当然uはunsignedのu
特に指定しないとintが選ばれるらしい。
intが何ビットなのかは書いてなかった。
  挙動を見る感じint32っぽいけど・・・
演算は
  + - * div mod < <= == != > >=
が定義されている。
ビット演算は
  and or xor not shl(左シフト) shr(右シフト)
]#

# これはint型
var i = 0
# 'を使ったsuffixで型を指定
var i_8 = 0'i8
echo "floatには.toFloatとかを使う : ", i.toFloat

# overflowやunderflowエラーは起きないらしい。
var ui = 0'u8
echo ui-1 # 255と出る。


# float
# 浮動小数
#[
float float32 float64
使える演算子は
  + - * / < <= == != > >=
指定がないとfloatになる
現状の実装ではfloatは"常に"64ビットらしい
]#

# int同様'で型を指定することもできる。
var fl = 1.25'f32

# 少数は切り捨てされる。
echo "float -> int : ", fl.toInt

# advanced types
# type文
#[
  後述のenum(列挙型)とobjectはここでしか書けない
  object型が何か分からない。
]#

# Cで言う所の typedef というやつであろう
type
  biggestInt = int64      # biggest integer type that is available
  biggestFloat = float64  # biggest float type that is available

# int32では表現できないはず。
var new_type: biggestInt = 1234_5678_9000_0000
#var new_type: int32 = 1234_5678_9000_0000 # コンパイルエラー。int64と言われる。
echo new_type

# Enumeration
# 列挙型

# Cの列挙型とは少し違う？内部的には0,1,..という管理はされているようだ
# コピペ
type
  Direction = enum
    north, east, south, west
    # 特に指定がないと１項目から順に0,1,2, ...となる

var d = south     # `x` is of type `Direction`; its value is `south`
echo d            # writes "south" to `stdout`
# 一応型はDirection型になるので他型とは比較はできない。のでCよりは使いやすい気もする。
# $d == "south"は成り立つ。

# 番号も変えられる。
type
  MyEnum = enum
    apple = 2, berry = 4, chocolate = 89, durian #durianは90になる。

# ordinal types
#[
漏れのないenum、int、char、boolはordinal typesと呼ばれる。
それらにはいくつか特別なオペレーションがあるそう。
めんどいのでコピペ
ord(x)      returns the integer value that is used to represent x's value
inc(x)      increments x by one
inc(x, n)   increments x by n; n is an integer
dec(x)      decrements x by one
dec(x, n)   decrements x by n; n is an integer
succ(x)     returns the successor of x
succ(x, n)  returns the n'th successor of x
pred(x)     returns the predecessor of x
pred(x, n)  returns the n'th predecessor of x
]#

# 気持ちはわかる気もするけど、どういうことやねんって感じでもある。
# プログラム理論系の人から見るとどうなんだろう。
echo succ(false)

# こっちは、その、多少はね？
echo ord(false)

# Subrange
#[
整数型かEnum型の一部範囲から構成される型を作れる。
範囲外を参照するとエラー。
コンパイル時には判定されない。
]#
type
  Subrange = range[0..5]
  NN = range[0..high(int)] # high()は指定された型の最大の数を返すらしい。

var sub_range: Subrange = 0
for s in 0..10:
  sub_range = sub_range + 1
  echo sub_range # 実行時エラーで落ちる
  break

# Set
# 集合
#[
pythonにもあったset
実装の都合上？で使える型は制限されている。
  int8-int16
  uint8/byte-uint16
  char
  enum
これ以外の型を使うとエラー
]#

type
  CharSet = set[char]
var
  c_set: CharSet
  # setとすればいいのでtype使わなくても。
  i_16: set[int16]

# aからy、0から9までの文字
c_set = {'a'..'y', '0'..'9'} 
echo c_set

# 和集合
echo c_set+{'z'}
# 差集合
echo c_set-{'a'..'s'}

#[
具体的な演算子は以下

A + B           union of two sets
A * B           intersection of two sets
A - B           difference of two sets (A without B's elements)
A == B          set equality
A <= B          subset relation (A is subset of B or equal to B)
A < B           strong subset relation (A is a real subset of B)
e in A          set membership (A contains element e)
e notin A A     does not contain element e
contains(A, e)  A contains element e
card(A)         the cardinality of A (number of elements in A)
incl(A, elem)   same as A = A + {elem}
excl(A, elem)   same as A = A - {elem}

]#


# Array
# 配列

# []で要素を囲むことでできる。pythonでいうlist
var arr = [0,1,2,3,4,5]
for i in arr:
  echo i

# array[range, type]で "0" から始まって "５" までの要素のtype型の配列ができる。
type 
  array_size6 = array[0..5, int] # 領域を確保しただけ

  # array[size, type]で0から始まるsize文の大きさの配列を作れる。
  array_size6_alt = array[6, int]

var array_6: array_size6
# デフォルト初期化で中身全部0
echo repr(array_6) #reprは後述
# サイズが合わないとエラー
# array_6 = [0,1,2,3,4,5,6]
# array_6 = [0,1,2,3]
array_6 = [0,1,2,3,4,5]

# わざわざ0から始まって...とつけたのは0から始める必要がないからである。
# が、個人的には全く推奨したくない。
type
  # 1から始まって10までの配列
  IntArray2 = array[1..10, int]
var strange_arr: IntArray2
strange_arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# 怖い時はこうしたほうがいい？勝手にindexの開始位置と終わりを整えてくれる。
# for in strange_arr: で事足りそうなのでいらなさそうだけど...
for i in low(strange_arr)..high(strange_arr):
  echo strange_arr[i]

# エラー
# echo strange_arr[0]
echo strange_arr[1]

#めんどいの丸コピ。こういう例もある。
type
  BlinkLights = enum
    off, on, slowBlink, mediumBlink, fastBlink
  LevelSetting = array[north..west, BlinkLights]
var
  level: LevelSetting
# northとかは前に出てきているDirectionやつ。
level[north] = on
level[south] = slowBlink
level[east] = fastBlink
echo repr(level)  # --> [on, fastBlink, slowBlink, off]
echo low(level)   # --> north
echo len(level)   # --> 4
echo high(level)  # --> west

# インデックスはpythonのenumerateみたいなのがなくても取り出せる
for idx, num in strange_arr:
  echo "idx=", idx, ", num=", num

# slice
# 部分を取り出せる。
echo array_6[1..4]

#[
  --bound_checks:off 
  で境界条件のチェックを外せるらしいので、
  C言語っぽく死ぬまで要素外に書き込みたいなら
  つけるといいんじゃないですか？
]#

# Sequences
#[
可変長配列、vecというところだろうか。
必ずヒープ上に確保されて、GCによって回収される。
Sequencesは必ず0からのインデックスで始まる。
len, low, highメソッド・procedureが使える。
]#
# int型のsequence
var seq_int: seq[int]
# 初期値はnil
echo repr(seq_int) 

# 配列に対して @ を使うことでSequenceに変換できる。
seq_int = @[1, 2, 3, 4, 5, 6]
# メモリ番地付きで表示される。
echo repr(seq_int)
# 中身の表示。なぜか配列は表示できないのこっちはできる...
echo seq_int

# 中身を増やすにはaddを使えばいい。他のメソッドはドキュメント見て！
seq_int.add(100)
echo seq_int

# 配列同様にindexもとれる。
for idx, num in strange_arr:
  echo "idx=", idx, ", num=", num

# slice
# 部分を取り出せる。
echo seq_int[1..4]

# 内部的な型表現(直訳)
#[
basicな方は全てechoで表示できるけど、
ユーザのオリジナルな型の場合$演算子を定義して
文字列に直さないと表示できない。が、
repr()を使うことによってどんなものでも表示できる。
ただし、微妙に表示が違うことに注意。
]#

# チュートリアルから丸コピ
var
  myBool = true
  myCharacter = 'n'
  myString = "nim"
  myInteger = 42
  myFloat = 3.14
echo myBool, ":", repr(myBool)
# --> true:true
echo myCharacter, ":", repr(myCharacter)
# --> n:'n'
echo myString, ":", repr(myString)
# --> nim:0x10fa8c050"nim"
echo myInteger, ":", repr(myInteger)
# --> 42:42
echo myFloat, ":", repr(myFloat)
# --> 3.1400000000000001e+00:3.1400000000000001e+00

# 型変換
#[
上の例でも示したように
  .toInt .toFloat
メソッド？を使うのと
  int() float()
のようにprocedureで変換もできる。
int32()はあるけど.toInt32はないようである。
詳しくはドキュメントを。
]#
var
  x: int32 = int32(12345)
  y: int8  = int8('a')
  z: float = float(y)
  # 当然同じint系列でも型が違うとコンパイルエラー
  # w: int32 = int64(x)

echo x
echo y
echo z

# int8をint32には代入できる。
x = y
echo x

# 当たり前だが上位互換はない。コンパイルエラー
# y = int64(x)
# echo y

# 文字列->数値
# strutilsモジュールで変換できるらしい
from strutils import parseInt, parseFloat
let
  pi = "3.14"

# エラーになる。
# echo pi + 2.71
echo pi.parseFloat + 2.71

# これはエラーになる。どうやら無理やり整数にはしてくれないらしい。
# echo pi.parseInt
echo int(pi.parseFloat)

# 配列の表示
let ar = [1, 2, 3, 4, 5]
# echo arr  # エラー
# echo $arr  # エラー
# repr使うとうまく行く
echo repr(ar)
