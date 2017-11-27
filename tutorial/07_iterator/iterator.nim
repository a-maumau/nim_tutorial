# イテレータ

echo "Counting to ten: "
# countupは典型的なイテレータ
# 呼び出されるたびに、その回数に合わせたシーケンスの内容を吐き出してくイメージだろうか
for i in countup(1, 10):
  echo i

# counupを自前で実装するとこうだろうか？
#[
proc my_countup(a, b: int): int =
  var res = a
  while res <= b:
    return res # 文法的にはここでエラー、returnの後に文はおけないらしい。
    inc(res)

しかし、実際のところこれではただ単に
最初のループで値を返して終わってしまう。
]#

# イテレータの定義
# iteratorキーワードを使って定義する
iterator my_countup(a, b: int): int =
  var res = a
  while res <= b:
    # returnではなく yieldを使う。
    yield res
    inc(res)

#[
イテレータは
  forループのみで呼ぶことができる。
  return文は書けない
  result変数は宣言されていない
  再帰呼び出しはできない
  前方宣言できない (そのうちできるようになるかも？)
などの特徴がある。
詳しくはドキュメントを参照・
]#

for i in my_countup(1, 10):
  echo i