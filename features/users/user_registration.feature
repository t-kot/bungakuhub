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
    かつ "ユーザ登録"ボタンをクリックする
    ならば "送られました"と表示されていること
  シナリオ: 登録されているメールアドレスとパスワードで登録しようとする
    もし "ユーザ登録ページ"へアクセス
    かつ "user_email"に"tanaka@kakuei.com"と入力する
    かつ "user_password"に"tanaka"と入力する
    かつ "user_display_name"に"User1"と入力する
    かつ "user_password_confirmation"に"tanaka"と入力する
    かつ "ユーザ登録"ボタンをクリックする
    ならば "保存されませんでした"と表示されていること
