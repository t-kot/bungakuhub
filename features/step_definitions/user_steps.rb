#coding: utf-8
#language: ja

もし 'ユーザとしてログインしている' do
  visit new_user_session_path
  fill_in "メールアドレス", with:"email1@example.com"
  fill_in "パスワード", with:"testtest"
  click_button("ログイン")
  @current_user = User.find_by_email("email1@example.com")
end

もし /^以下のユーザが存在している:$/ do |table|
  table.rows.each do |email, display_name|
    FactoryGirl.create(:user, email:email, display_name:display_name)
  end
end

もし /^メールアドレスが"(.*)"のユーザとしてログインしている$/  do |email|
  visit new_user_session_path
  fill_in "メールアドレス", with: email
  fill_in "パスワード", with: "testtest"
  click_button("ログイン")
  @current_user = User.find_by_email(email)
end

もし /^"(.*)"としてログインしている$/ do |name|
  user = User.find_by_display_name(name)
  visit new_user_session_path
  fill_in "メールアドレス", with: user.email
  fill_in "パスワード", with: "testtest"
  click_button("ログイン")
  @current_user = user
end
