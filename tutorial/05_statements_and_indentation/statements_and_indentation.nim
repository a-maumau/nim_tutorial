# statements and ubdentation ################################

discard """
  単純文と複合文が区別される。
  単純文は他の文を含むことができない。
  単純文に属するのは、代入文やプロシージャ呼び出し文、return文である。
  一方、if、when、for、whileといった複合文は他の文を含むことができる。
  「曖昧さ回避」のため、複合文はインデントを必要とするが、単純文はインデントする必要はない。

  引用　https://qiita.com/KTakahiro1729/items/f4776f3a072c01f9086b#fn8
"""

var x = true
var y = false

# 代入文が一つなので、インデントは必要ない
if x: x = false

# 入れ子構造のif文にはインデントが必要
if x:
  if y:
    y = false
  else:
    y = true

# これはエラー
# if x: if y: y=false

# 文が二つ続くため、インデントが必要である。
if x:
  x = false
  y = false

# 式の中にインデントを入れることは問題ない。
if true and
   true and
   true or
   false:
  #ここの間のインデントの高さは揃ってなくてもいいようだ...
  echo "true?"

# こういうこともできる。
const sum_of_1_to_10 = (var sum = 0; for i in 1..10: sum += i; sum)
echo sum_of_1_to_10
#[ 
  解釈としては、
  カッコ内を無名関数あるいは一つの式としてみて、
  最後に評価されたものを返り値としている
  というところだろうか？
  あとでちゃんとした理解をした方がいいのかもしれない。
]#

# これはエラー
# const sum_of_1_to_10 = var sum = 0; for i in 1..10: sum += i; sum