#coding: utf-8
#language: ja

機能: レポジトリのポストを作成/更新/削除する
  レポジトリ所有者として
  レポジトリの実体のテキストを編集したい

  シナリオ: 新しくポストを作成する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    もし "repo1のmasterブランチのエディタ"へアクセス
    かつ タイトルが"New"で本文が"New Body"のポストを作成する
    ならば ポストが作成されること
  シナリオ: 既に存在するポストを作成しようとして失敗する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のポストが存在している:
      |repository |branch |title  |body|
      |repo1      |master |hoge   |hoge|
    もし "repo1のmasterブランチのエディタ"へアクセス
    かつ タイトルが"hoge"で本文が"New Body"のポストを作成する
    ならば ポストの作成に失敗すること

  シナリオ: 既に存在するポストを更新する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のポストが存在している:
      |repository |branch |title  |body|
      |repo1      |master |hoge   |hoge|
    もし "repo1のmasterブランチのエディタ"へアクセス
    かつ "hoge"の本文を"fuga"に更新する
    ならば ポストの更新に成功すること

  シナリオ: 既に存在するポストを、別のすでに存在するポスト名にして更新する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    かつ 以下のポストが存在している:
      |repository |branch |title  |body|
      |repo1      |master |hoge   |hoge|
      |repo1      |master |fuga   |hoge|
    もし "repo1のmasterブランチのエディタ"へアクセス
    かつ "hoge"のタイトルを"fuga"に更新する
    ならば ポストの更新に失敗すること
