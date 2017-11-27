# procedurs ################################

# ちなみに"func"は予約語になってます。

# Nimでは他の言語でいうとこの関数をprocedureと呼ぶ
# proc function_name( arg: var_type, ...): return_type = ... の形をとる。
#[
  C言語でいうなら
  return_type function_name(var_type arg, ...)
  {
    ...
  }
  という感じ
]#
proc yes(question: string): bool =
  echo question, " (はい/いいえ)"
  while true:
    case readLine(stdin)
    of "はい", "そうだよ(便乗)", "yes": return true
    of "いいえ", "no": return false
    else: echo "「はい」か「いいえ」で答えてください"

if yes("あなたはロリコンである。"):
  echo "通報した。"
else:
  echo "ダウト、通報した。"

# 単純文なら一行にまとめられる。
proc say_yes() = echo "yes"

# 引数・返り値を持つときはそれぞれ肩を指定する必要がある。
# proc f(x) = # コンパイルエラー
proc f(x:int):float =
  if x == 0:
    return 0
  else:
    return 0.5


# result変数 ################################
#[
  返り値を持つprocedureは暗黙的に
  resultという変数名の変数が返り値の型の
  デフォルト初期値で初期化されている。
  return で何も指定しない、あるいはreturnも指定しないと
  resultが暗黙的にreturnされている
]# 

proc result_kaesu(x:int): float =
  if x == 0:
    return 10
  elif x == 1:
    return 0.5
  elif x == 2:
    return #result
  else:
    echo "else"
    # return result

echo result_kaesu(2)
echo result_kaesu(3)

# resultを書き換えることもできる
proc result_kaesu2(): int = 
  result = 10 # var resultがなくても書き換えられる。
  return

echo "new result value:",result_kaesu2()

# 引数にresultを含めると重複と怒られる。
# proc init_result(result:int):int = return


# discard ################################
#[
  discard文はその文を無視するという使い方で紹介したが、
  返り値を持つprocedureを返り値を捨てて使う時は必ず
  discardしないといけない。
]#
# コンパイルエラー
# result_kaesu2()

discard result_kaesu2()

# あるいはdiscardableプラグマ使うことで明示的に書かなくてもすむ
proc discard_return(): int {.discardable.} =
  return 100

discard_return()


# パラメータ(引数) ################################
# procedureに渡されているパラメータは基本的にconstとして扱われる
# 理由としてはその方が効率がいいのだそうな。
# まぁ、Cでいうところのポインタ使ってないやつね。
proc function(x:int, y:int): int = 
  # 代入できないのでコンパイルエラー
  # x = x+y

  # いわゆるシャドーイングして上書きするのが慣用的に用いられるらしい
  var x = x+y
  return x

echo function(1,2)

# 複数変更したいんだ！ってのも当然あるので
# 書き換えられるようにもできます！これで安心(?)！
# 型の前に var をつけるだけ
proc function_var(x:var int, y:var int)=
  x += 1
  y = x+y

var v1,v2 = 5
echo "v1:",v1, " v2:",v2
function_var(v1, v2)
echo "v1:",v1, " v2:",v2

# 名前付き引数とデフォルト値 ################################
# 名前付き引数
proc named_param(db_name, command: string, user_id:int)=
  echo "db_name ", db_name
  echo "command ", command
  echo "user_id ", user_id

# どのパラメータに渡すかを記述すれば、引数の順序を入れ替えてもよい
named_param(user_id=114514,
            db_name="db.north-east.japan",
            command="sudo rm -rf /")

# named_param(db_name, command: string; user_id:int)
# のように "," を ";"にしてもよいようだ、

# これでクソみたいな関数を作っても大丈夫！ ※実際には許されない
# proc named_param_bad(height, name, weight, age:string)=

# デフォルト値
# 型推論によって型を指定しなくてもよい。
proc named_param2(age=15, height=160, weight=49, cv="早見沙織") =
  echo "age ", age
  echo "height ", height
  echo "weight ", weight
  echo "cv ", cv

named_param2(age=17)


# オーバーロード ################################
# procedureや演算子をオーバーロードすることができる。
proc div_x_by_y(x:int, y:int):int = 
  return int(x/y) # int型へのキャスト。Nimでは整数演算でも少数が出るようだ。

proc div_x_by_y(x:float, y:float):float = 
  return x/y

echo div_x_by_y(5,2)
echo div_x_by_y(5.0, 2.0)

# 仕様を読まないとわからないが、どうやらint ⊂ float という解釈がされる？
echo div_x_by_y(5.0, 2)
echo div_x_by_y(5, 2.0)

# 演算子の方は省略。


# 前方宣言 ################################
# 要は使う前に宣言されてないといけないということ。
# C言語でいうところのプロトタイプ宣言
# 宣言しているprocの"="から先を削ったものを書けばよい。

proc fact(n :int):int # ここがないとコンパイルエラー

echo fact(5)

proc fact(n :int):int =
  if n == 1:
    return 1
  else:
    return n*fact(n-1)


# 余談：パラメータの渡し方いろいろ ################################
#[
ここ書いてる段階ではどのような型があるのかまだいまいちなので
あとで書き足すと思うが、書けるものは書いておく
]#

# 任意の長さの引数の渡し方。
# varargsは引数の最後でのみ使える。
proc sumTillNegative(x: varargs[int]): int =
  for i in x:
    if i < 0:
      return
    result = result + i

echo sumTillNegative(1,2,3,4,5,-1,10,20)
# 型が違うものが入るとエラー
# echo sumTillNegative(1,2.0,3,4,5,-1,10,20)