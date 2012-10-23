#coding: utf-8
#language: ja

機能: ログイン
  ユーザがログインする


  シナリオ: 登録されているメールアドレス、パスワードでログイン
    もし 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
      |email2@example.com | user2|
    もし "ログインページ"へアクセス
    かつ "user_email"に"email1@example.com"と入力する
    かつ "user_password"に"testtest"と入力する
    かつ "ログイン"ボタンをクリックする
    ならば "ログアウト"と表示されていること
    かつ "むちゃくちゃな文字"と表示されていないこと
  シナリオ: 登録されていないメールアドレス、パスワードでログイン
    もし "ログインページ"へアクセス
    かつ "user_email"に"nise@kakuei.com"と入力する
    かつ "user_password"に"kakuei"と入力する
    かつ "ログイン"ボタンをクリックする
    ならば "違います"と表示されていること
  シナリオ: ログイン後にログアウトができる
    もし 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
      |email2@example.com | user2|
    かつ "ログインページ"へアクセス
    かつ "user_email"に"email1@example.com"と入力する
    かつ "user_password"に"testtest"と入力する
    かつ "ログイン"ボタンをクリックする
    かつ "ログアウト"リンクをクリックする
    ならば "ログアウトしました"と表示されていること
