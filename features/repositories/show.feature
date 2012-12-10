#coding: utf-8
#language: ja

機能: 作成したレポジトリを表示する
  一般のユーザとして
  作成されたレポジトリを見たい

  シナリオ: 閲覧する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    もし "repo1のレポジトリページ"へアクセス
    ならば 以下のレポジトリが表示されている:
      |repo_name  |type |
      |repo1      |1    |
