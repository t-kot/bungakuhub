# coding: utf-8
#language: ja

もし /言語は"(.*)"を選択/ do |language|
  visit "?locale=#{language}"
end

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

もし /^以下のレポジトリが存在している:$/ do |table|
  table.rows.each do |user, name, repository_type|
    user = User.find_by_display_name(user)
    FactoryGirl.create(:repository, user: user, name: name, repository_type_id: 1)
  end
end

もし /^以下のレポジトリが表示されている:$/ do |table|
  table.rows.each do |repo_name,type|
    step %Q["#{repo_name}"と表示されていること]

  end
end
もし /^以下のレポジトリが表示されていない:$/ do |table|
  table.rows.each do |repo_name,type|
    step %Q["#{repo_name}"と表示されていないこと]
  end
end
