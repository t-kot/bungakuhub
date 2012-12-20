#coding: utf-8
#language: ja

機能: 自分のタイムラインを表示する
  ログインユーザとして
  自分のタイムラインを表示したい
  他のユーザがどのような活動をしているか見たいから

  シナリオ: 閲覧する
    前提 以下のユーザが存在している:
      |email              |display_name|
      |email1@example.com |user1       |
      |email2@example.com |user2       |
      |email3@example.com |user3       |
    かつ 以下のフォロー関係が成立している:
      |follower           |following   |
      |user1              |user2       |
      |user1              |user3       |
    かつ 以下のツイートが存在する:
      |user               |tweet       |
      |user2              |hogehoge    |
      |user3              |fugafuga    |
    かつ "user1"としてログインしている
    もし フィードのタイムラインを表示している
    ならば 以下のフィードが表示されていること
      |hogehoge |
      |fugafuga |
