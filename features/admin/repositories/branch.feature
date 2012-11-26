#coding: utf-8
#language: ja

機能: ブランチを作成
  ユーザとして
  所有するレポジトリのブランチを作成したい
  ブランチによって開発のモード変更を容易にサポートするため

  シナリオ: ブランチを作成する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "repo1のmasterブランチのチェックアウト作成ページ"へアクセス
    もし "ブランチ名"に"develop"と入力する
    かつ "Save"ボタンをクリックする
    ならば "が作成されました"と表示されていること

  シナリオ: ブランチの作成に失敗する(すでにあるブランチ名)
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のブランチが存在している:
      |repo |branch|
      |repo1|dev|
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "repo1のmasterブランチのチェックアウト作成ページ"へアクセス
    もし "ブランチ名"に"dev"と入力する
    かつ "Save"ボタンをクリックする
    ならば "すでに存在します"と表示されていること

  シナリオ: Indexが追加されている(コミットはしていない)状態でチェックアウトする
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のポストが存在している:
      |repo     |branch   |title    |body|
      |repo1    |master   |hoge     |fuga|

    もし "repo1"の"master"ブランチから"dev"ブランチを作成する
    かつ "repo1のdevブランチのコミット作成ページ"へアクセス
    ならば "hoge"と表示されていないこと
