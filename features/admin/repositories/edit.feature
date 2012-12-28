#coding: utf-8
#language: ja

機能: 管理用のレポジトリ詳細ページから情報を編集
  ユーザとして
  所有するレポジトリの情報を編集する
  運用中に設定を変更したいから

  シナリオ: 正常に編集する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    もし "repo1のレポジトリ編集ページ"へアクセス
    かつ "repository_description"に"詳しい説明"と入力する
    かつ "更新"ボタンをクリックする
    ならば "更新されました"と表示されていること
  シナリオ: 該当ユーザ以外が編集する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
      |email2@example.com|  user2     |
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
      |user2    |repo2    |1              |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    もし "repo2のレポジトリ編集ページ"へアクセス
    ならば "許可されていないアクションです"と表示されていること
