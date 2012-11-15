#coding: utf-8
#language: ja

機能: 管理用のレポジトリ一覧表示
  ユーザとして
  所有するレポジトリの一覧を管理画面から見る
  一覧でfork数などの統計情報を見たいから

  シナリオ: レポジトリ一覧管理ページを表示する
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
    もし "レポジトリ管理ページ"へアクセス
    ならば 以下のレポジトリが表示されている:
      |name|repository_type|
      |repo1|1|
      |repo2|1|
    かつ 以下のレポジトリが表示されていない:
      |name|repository_type|
      |repo3|1|
      |repo4|1|
