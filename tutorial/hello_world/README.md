# コンパイル
コンパイルには  
```
nim compile hello.nim
あるいは
nim c hello.nim
```
とすればコンパイルされる。
`nim c --run hello.nim`または`nim c -r hello.nim`とするとコンパイルの後に実行される。  
引数を渡すには
```
nim compile --run hello.nim 引数1 引数2
```
とすればよい。

# releaseコンパイル
releaseでコンパイルするときには`-d:release`を追加して
```
nim c -d:release hello.nim
```
とすればいい。