#coding: utf-8
#language: ja

機能: レポジトリに対するブランチの作成
  あるレポジトリを持っているユーザとして
  そのレポジトリに対するブランチを作成したい
  ブランチによる分岐で柔軟な創作活動をサポートするため

  シナリオ: 正常にブランチをチェックアウトする
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
    かつ 以下のレポジトリが存在している:
      |owner | name | repository_type|
      |user1 | repo1| 1              |
    かつ "user1"としてログインしている
    もし "repo1のmasterブランチのチェックアウト作成ページ"へアクセス
    かつ "dev"という名前でブランチを作成する
    ならば 正常にブランチが作成されていること
  シナリオ: ブランチのチェックアウトに失敗する
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
    かつ 以下のレポジトリが存在している:
      |owner | name | repository_type|
      |user1 | repo1| 1              |
    かつ "user1"としてログインしている
    もし "repo1のmasterブランチのチェックアウト作成ページ"へアクセス
    かつ "master"という名前でブランチを作成する
    ならば "ブランチ名はすでに存在します"と表示されていること

  シナリオ: INDEXが更新されている状態でチェックアウトする
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のポストが存在している:
      |repo     |branch   |title    |body|
      |repo1    |master   |hoge     |fuga|
    かつ "user1"としてログインしている
    もし "repo1のmasterブランチのチェックアウト作成ページ"へアクセス
    ならば 一度コミットを要求すること
