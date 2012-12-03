#coding: utf-8
#language: ja

機能: レポジトリのコミット一覧を表示する
  すべてのユーザとして
  レポジトリのコミット履歴を見たい

  シナリオ: コミット履歴が表示される
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
    もし "repo1のmasterブランチのコミット一覧ページ"へアクセス
    ならば "commit1"コミットが存在すること
