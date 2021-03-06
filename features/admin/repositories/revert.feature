#coding: utf-8
#language: ja

機能: レポジトリをrevertする
  レポジトリ所有者として
  特定の時点にコミットを巻き戻したい

  シナリオ: 正常にRevertする
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のコミットが存在している:
      |repository|branch|msg|
      |repo1     |master|commit1|
      |repo1     |master|commit2|
