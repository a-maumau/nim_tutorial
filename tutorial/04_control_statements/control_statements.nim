# 制御文
# if文 ################################
echo "名前を"
let name = readLine(stdin)
# if 評価式: という形式をとる。
if name == "":
  echo "やぁ、名無し君！"
# else if の意味。実際には"else if"も"else"の中の"if"でしかないのだけれど
elif name == "名前":
  echo "名前って名前なの？"
else:
  echo "ごきげんよう ", name, "!"

# 単文であればインデントは必要ない。
if name == "name": echo "インデントいらない。"
# ;を使えば一応複数かけるが可読性に欠ける。
elif name == "mau": echo "どうも"; echo";で同じ行にもかける"
else: echo "楽しいNim"

# and と or, not
if true and false:
  echo "この文は表示されない"
if false or not false:
  echo "and と or はそのまんま、否定はnot"

let this_is_true = 1
# これはエラー
# if this_is_true: echo "これはダメです"
# 暗黙の型変換のようなことはやってくれない。
# bool型(true, false)のみである。

# case文 ################################

#これは後ほど
from strutils import parseInt

echo "数字を入力してください: "
let n = parseInt(readLine(stdin))
# :ないのが気持ち悪い、悪くない？
case n
of 1192:
  echo "鎌倉幕府！"
  # break は不要
# もちろん単文ならインデントは不要
# ..を使った範囲指定もできる。
of 0..2, 4..7: echo "入力した数字は以下の集合に属しています: {0, 1, 2, 4, 5, 6, 7}"
of 3, 8: echo "入力した数字は3か8です"
# 違う型を比較しようとするとコンパイルエラー
# of "aa": echo "文字"
else: discard # ここがないとコンパイルエラーになる。
#[
上記でelseの部分がないとエラーになるのはcase文が
全てのパターンを網羅できてないためである。
コンパイラが教えてくれているのはありがたい。
]#

# 実はどうやらこう書ける。こっちの方が精神衛生上いい気がする...
case n:
  of 0:
    echo "0"
  else:
    discard

# when文 ################################

# when-elif-else形式で書く。
when system.hostOS == "windows":
  echo "running on Windows!"
elif system.hostOS == "linux":
  echo "running on Linux!"
elif system.hostOS == "macosx":
  echo "running on Mac OS X!"
else:
  echo "unknown operating system"

# 評価される式はコンパイルの時点で決まっていないといけない
var i: int
# コンパイルエラーとなる
# when i == 1: echo "ダメ"

const w = 1
when w == 0:
  var x = 0
elif w == 1:
  var x = 1

echo "whenは新しいスコープを作らない。x=",x

if w == 1:
  var y = 1
# コンパイルエラーとなる。
#echo y

when false:
  """
    こうすれば
    長
    い
    コ
    メ
    ン
    ト
    も書くことができる。
    discardと似たように使えます。
  """

#[
whenの使い方はC/C++で言う所の#ifdefのような感じである。
if文との違いをまとめると
  コンパイル時に評価する式が決まっていないといけない
  ブロックの中で新しいスコープを作らない。
である。
コンパイルされた時点でtrueだった部分のみがコンパイルされるため
実際のコードはブロックの中のコードだけが残されるのでスコープが新たに
生成されるわけでないのが直感的にわかる。
]#

# while文 ################################

echo "お名前は？"
var name2 = readLine(stdin)
while name == "":
  echo "名前を入力してください "
  name2 = readLine(stdin)

i=0
# もちろんインデントなしでも
while i<10: i += 1
# i++という表現はできなくなったので注意

# for文
echo "10まで数え上げる"
for i in countup(1, 10):
  # $は文字列に直すという演算子。必要ではない。
  echo $i

echo "カウントダウン"
for i in countdown(10, 1):
  echo $i

echo "..記法"
# このようにも書ける
for i in 1..10:
  echo $i

# block, break, continue文 ################################

var flag=false
var j:int
# blockはgotoなどのラベルに似ている。
block label:
  echo "ブロック文に入りました。"
  
  var block_var=0 # 特に使わない
  for i in 1..5:
    echo "１個目のfor文の中"
    # iが2の時だけ echo i 以下の文を実行せずにforに戻る。
    if i == 2:
      echo "2はスキップ"
      # continueにはラベル名は使えない。
      continue

    echo i
    
    for j in 1..3:
      if i == 4:
        # labelブロックを抜けるため、iが5の時は実行されない
        break label
      echo "２個目のfor文の中"

# block文はスコープを作るのでコンパイルエラーになる。
# echo block_var

# これは実行時エラーになるよう
#block label2:
#  echo "aaaa"
#  continue # SIGSEGV引き起こすらしい、コンパイラの反応的に。

#[
混乱しないようにまとめ
スコープを作らないのは
  when文
のみ。

breakは直前以外にはblock文で作られた
ラベルのブロックから出ることができる。
continueは直前のfor,whileの続きにすぐ行ける。
]#
