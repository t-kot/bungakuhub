#coding: utf-8
#language: ja

機能: 管理用のレポジトリ詳細ページ
  ユーザとして
  所有するレポジトリの詳細情報を管理画面から見る
  個別に詳細な情報を見たり、編集したいから

  シナリオ: レポジトリ詳細管理ページを表示する
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
    もし "repo1のレポジトリ詳細ページ"へアクセス
    ならば "repo1"と表示されていること
  シナリオ: 他人のレポジトリ詳細ページを表示する
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
    かつ メールアドレスが"email2@example.com"のユーザとしてログインしている
    もし "repo1のレポジトリ詳細ページ"へアクセス
    ならば "許可されていない"と表示されていること
