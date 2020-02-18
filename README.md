# PagingできるTabのSample

## 仕様
- 最初は一番左のcellがPagingの真ん中にくる
- 左右にスワイプしてcellを変更できる
- タップしたまま左右に移動した場合も、中途半端な部分では止まらず、必ず真ん中で何かのRankにフォーカスしている状態になる
- スワイプのスピード幅によって、移動するRank幅も変わる。スワイプがゆっくり小さい範囲なら1個ずれる、スワイプが早く大きい幅ならたくさんずれる

実装したもの

![PagingCollection](https://user-images.githubusercontent.com/8661733/74798564-6e66c600-5311-11ea-97fb-4522865c903a.gif)

参考にしたもの

![Sample Gif](https://user-images.githubusercontent.com/8661733/74706320-ed002c80-5259-11ea-9f99-3e465e330617.gif)
