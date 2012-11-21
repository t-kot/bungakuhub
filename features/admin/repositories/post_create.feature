#coding: utf-8
#language: ja

機能: ポストを作成する

  シナリオ: 正常に作成する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    もし "repo1のmasterブランチのポスト一覧ページ"へアクセス
    もし タイトルが"hoge",本文が"fuga"のポストを作成する
    ならば "作成されました"と表示されていること
  シナリオ: タイトルがないために作成に失敗する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    もし "repo1のmasterブランチのポスト一覧ページ"へアクセス
    もし タイトルが"",本文が"fuga"のポストを作成する
    ならば "タイトルを入力してください"と表示されていること
  シナリオ: 同名のポストがすでにあるために作成に失敗する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のポストが存在している:
      |repository|branch|title|body|
      |repo1     |master|hoge |fuga|
    もし "repo1のmasterブランチのポスト一覧ページ"へアクセス
    もし タイトルが"hoge",本文が"fuga"のポストを作成する
    ならば "すでに"と表示されていること
