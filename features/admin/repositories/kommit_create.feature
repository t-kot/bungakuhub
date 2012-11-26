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
    かつ 以下のポストが存在している:
      |repository|branch|title|body|
      |repo1     |master|hoge |fuga|
    もし "repo1のmasterブランチのコミット作成ページ"へアクセス
    かつ "hogeを作成"をコミット
    ならば "作成されました"と表示されていること

  シナリオ: コミットに失敗する(kommitのmessageがない)
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
    もし "repo1のmasterブランチのコミット作成ページ"へアクセス
    かつ ""をコミット
    ならば "保存されませんでした"と表示されていること
