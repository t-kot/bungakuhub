#coding: utf-8
#language: ja

機能: ユーザ登録
  ユーザが新規登録をする

  シナリオ: 登録されていないメールアドレスとパスワードで新規登録
    もし "ユーザ登録ページ"へアクセス
    かつ "user_email"に"fukuda@takeo.com"と入力する
    かつ "user_password"に"fukuda"と入力する
    かつ "user_display_name"に"fukuda"と入力する
    かつ "user_password_confirmation"に"fukuda"と入力する
    かつ "Sign up"ボタンをクリックする
    ならば "送られました"と表示されていること
