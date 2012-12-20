#coding: utf-8
#language: ja

機能: 新しくユーザをフォローする
  フォローボタンからユーザをフォローする
  ネットワークを拡大させるため

  シナリオ: フォローする
    前提 以下のユーザが存在している:
      |email              |display_name|
      |email1@example.com |user1       |
      |email2@example.com |user2       |
    かつ "user1"としてログインしている
    #もし "user2のプロフィールページ"へアクセス
    かつ user2のプロフィールからフォローする
    かつ "user1のフォロー対象一覧ページ"へアクセス
    ならば 以下のユーザが一覧に表示されていること:
      |user |
      |user2|

