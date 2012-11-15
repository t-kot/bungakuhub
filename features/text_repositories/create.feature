#coding:utf-8
#language: ja

機能: テキストレポジトリの作成
  ユーザがテキストレポジトリを作成する
  シナリオ: テキストレポジトリ作成ページを表示する
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
      |email2@example.com | user2|
    もし メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "user1のテキストレポジトリ作成ページ"へアクセス
    ならば "公開"と表示されていること
    かつ "プライベート"と表示されていること
    かつ "レポジトリ名"と表示されていること

  シナリオ: ログイン後、正しい値でテキストレポジトリを作成
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
      |email2@example.com | user2|
    もし メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "user1のテキストレポジトリ作成ページ"へアクセス
    かつ "text_repository_repository_type_id_1"を選択する
    かつ "レポジトリ名"に"テストのレポジトリ"と入力する
    かつ "説明"に"これはcucumberによって作成しました"と入力する
    かつ "作成"ボタンをクリックする
    ならば "が作成されました"と表示されていること
  シナリオ: ログイン後、不正な値でテキストレポジトリを作成
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
      |email2@example.com | user2|
    もし メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "user1のテキストレポジトリ作成ページ"へアクセス
    かつ "text_repository_repository_type_id_1"を選択する
    かつ "レポジトリ名"に""と入力する
    かつ "説明"に"これはcucumberによって作成しました"と入力する
    かつ "作成"ボタンをクリックする
    ならば "は保存されませんでした"と表示されていること
  シナリオ: ログインせずに、テキストレポジトリを作成しようとする
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
    もし "user1のテキストレポジトリ作成ページ"へアクセス
    ならば "ログインしてください"と表示されていること
