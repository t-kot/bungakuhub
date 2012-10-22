# coding: utf-8
#language: ja

もし /言語は"(.*)"を選択/ do |language|
  visit "?locale=#{language}"
end

もし 'ユーザとしてログインしている' do
  visit new_user_session_path
  fill_in "メールアドレス", with:"tanaka@kakuei.com"
  fill_in "パスワード", with:"tanaka"
  click_button("ログイン")
end
