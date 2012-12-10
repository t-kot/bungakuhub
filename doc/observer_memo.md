# Observer
注意点

### Observerに対する注意
Observerに含めるかどうかの指針=> その処理が他のオブジェクトの状態などに依存しないときに限りObserverに含めて良い。 **他のオブジェクトの状態を引数に受け取るような処理を書くべきではない**

### Observerのそれぞれの役割

#### RepositoryObserver
* before_create  
  * 実体のワーキングツリーを提供する

* after_create
  * git initする
  * masterブランチのオブジェクトを作成する(コールバックは走らない)
  * READMEのPostを作成する
  * First Commitを作成する

* before_destroy
  * 対象のレポジトリのワーキングツリーを削除する
  
  
#### BranchObserver
* before_create
	* 対応するワーキングツリーにその名前のブランチを作成する
* after_create
	* (checkoutのときのみ)Postを作成する=>実際にcheckoutしてそのワーキングツリーの内容をPostに書き出す

* before_destroy
	* gitの実際のブランチを削除する

#### PostObserver
* after_create
	* Postに対応するファイルをワーキングツリーに作成して、addする

* before_update
	* Titleがrenameされていたらファイルをrenameする
	* Postの内容を作成してaddする(既にある場合でも上書きする)

* before_destroy
	* 実際のファイルを削除する
	* gitからremoveする

#### KommitObserver
* before_create
	* 実際にgitにおいてcommitする
	* revisionをセットする(このときにどのブランチにおいてKommitオブジェクトが作成されたかを、init_atで知っておく必要がある)

  
  



