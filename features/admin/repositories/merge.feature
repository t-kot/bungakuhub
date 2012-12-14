#coding: utf-8
#language: ja

機能: マージ
  ユーザとして
  持っているレポジトリのブランチをマージしたい

  シナリオ: マージする
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ "user1"としてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のコミットが存在している:
      |repository |branch |msg    |
      |repo1      |master |commit1|
    かつ "repo1"の"master"ブランチから"dev"ブランチを作成する
    かつ 以下のコミットが存在している:
      |repository |branch |msg    |
      |repo1      |dev    |commit2|
    もし "repo1のmasterブランチのマージ作成ページ"へアクセス
    かつ "dev"をマージする
    ならば "マージされました"と表示されていること
    かつ repo1のmasterブランチにMerge branch devコミットが存在すること

  シナリオ: マージするがコンフリクトする
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ "user1"としてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ "repo1"の"master"ブランチにタイトルが"hoge"で本文が"fuga"のポストを作成する
    かつ "repo1"の"master"ブランチを"add hoge"というメッセージでコミットする

    かつ "repo1"の"master"ブランチから"dev"ブランチを作成する
    かつ "repo1"の"master"ブランチのポストを以下のように編集する:
      |title_before |title_after  |body |
      |hoge         |hoge         |testtest|
    かつ "repo1"の"master"ブランチを"modify hoge"というメッセージでコミットする
    かつ "repo1"の"dev"ブランチのポストを以下のように編集する:
      |title_before |title_after  |body |
      |hoge         |hoge         |testtest|
    かつ "repo1"の"dev"ブランチを"modify hoge"というメッセージでコミットする
    もし "repo1のmasterブランチのマージ作成ページ"へアクセス
    かつ "dev"をマージする
    ならば "マージされました"と表示されていること
    かつ repo1のmasterブランチにMerge branch devコミットが存在しないこと
