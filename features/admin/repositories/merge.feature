#coding: utf-8
#language: ja

機能: マージ
  ユーザとして
  持っているレポジトリのブランチをマージしたい

  シナリオ: 新規マージページを表示する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
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
