#coding: utf-8
#language: ja

機能: レポジトリをコミットする
  レポジトリの所有者として
  コミットを作成したい

  シナリオ: 正常にコミットする
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    もし "repo1のmasterブランチのコミット作成ページ"へアクセス
    もし タイトルが"hoge",本文が"fuga"のポストを入力する
    かつ "hogeを作成"をコミット
    ならば "作成されました"と表示されていること

  シナリオ: コミットに失敗する
    前提 以下のユーザが存在している:
      |email             |display_name|
      |email1@example.com|  user1     |
    かつ メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ 以下のレポジトリが存在している:
      |user     |name     |repository_type|
      |user1    |repo1    |1              |
    もし "repo1のmasterブランチのコミット作成ページ"へアクセス
    もし タイトルが"hoge",本文が"fuga"のポストを入力する
    かつ ""をコミット
    ならば "保存されませんでした"と表示されていること

  シナリオ: 不正な名前のファイルを作ろうとする

