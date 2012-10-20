#coding: utf-8
#language: ja

機能: ログイン
  ユーザがログインする

  シナリオ: 登録されているメールアドレス、パスワードでログイン
      もし ユーザ名が"User1"のユーザがいる
      かつ "ログインページ"へアクセス
      かつ "user_email"に"tanaka@kakuei.com"と入力する
      かつ "user_password"に"tanaka"と入力する
      かつ "Sign in"ボタンをクリックする
      ならば "Out"と表示されていること
  シナリオ: 登録されていないメールアドレス、パスワードでログイン
      もし "ログインページ"へアクセス
      かつ "user_email"に"nise@kakuei.com"と入力する
      かつ "user_password"に"kakuei"と入力する
      かつ "Sign in"ボタンをクリックする
      ならば "Invalid"と表示されていること
  シナリオ: ログイン後にログアウトができる
      もし ユーザ名が"User1"のユーザがいる
      かつ "ログインページ"へアクセス
      かつ "user_email"に"tanaka@kakuei.com"と入力する
      かつ "user_password"に"tanaka"と入力する
      かつ "Sign in"ボタンをクリックする
      かつ "Sign Out"リンクをクリックする
      ならば "Signed out successfully"と表示されていること
