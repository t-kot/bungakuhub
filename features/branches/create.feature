#coding: utf-8
#language: ja

機能: レポジトリに対するブランチの作成
  あるレポジトリを持っているユーザとして
  そのレポジトリに対するブランチを作成したい
  ブランチによる分岐で柔軟な創作活動をサポートするため

  シナリオ: ログイン後、ブランチ作成ページを表示する
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
    かつ 以下のレポジトリが存在している:
      |owner | name | repository_type|
      |user1 | repo1| 1              |
