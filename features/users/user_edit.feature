#coding: utf-8
#language: ja

機能: ユーザ情報の編集
  ユーザとして
  自らのユーザ情報を編集したい
  自分のプロフィールを充実させるため

  シナリオ: ログイン後、自分のユーザ情報を編集する
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
    もし メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "自分のプロフィール編集ページ"へアクセス

  シナリオ: ログイン後、他人のユーザ情報を編集しようとする
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
      |email2@example.com | user2|
    もし メールアドレスが"email1@example.com"のユーザとしてログインしている
