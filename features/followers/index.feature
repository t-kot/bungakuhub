#coding: utf-8
#language: ja

機能: 特定のユーザをフォローしているユーザ一覧を表示
  誰がフォローしているのかを見たい
  そこからネットワークを拡大させるため

  シナリオ: 閲覧する
    前提 以下のユーザが存在している:
      |email              |display_name|
      |email1@example.com |user1       |
      |email2@example.com |user2       |
      |email3@example.com |user3       |
      |email4@example.com |user4       |
    かつ 以下のフォロー関係が成立している:
      |follower           |following   |
      |user1              |user2       |
      |user1              |user3       |
    もし "user2のフォロワー一覧ページ"へアクセス
    ならば 以下のユーザが一覧に表示されていること:
      |user |
      |user1 |
