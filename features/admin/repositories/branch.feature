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
    かつ "repo1のブランチ作成ページ"へアクセス
    もし "Name"に"develop"と入力する
    かつ "Save"ボタンをクリックする
    ならば "が作成されました"と表示されていること

  シナリオ: ブランチの作成に失敗する(すでにあるブランチ名)
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "repo1のブランチ作成ページ"へアクセス
    もし "Name"に"master"と入力する
    かつ "Save"ボタンをクリックする
    ならば "すでに存在します"と表示されていること
  シナリオ: 異なるユーザとしてブランチを作成しようとする
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
      |email2@example.com|  user2     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
      |user1    |repo2    |1              |
      |user2    |repo3    |1              |
      |user2    |repo4    |1              |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    もし "repo3のブランチ作成ページ"へアクセス
    ならば "許可されていないアクションです"と表示されていること
