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

もし /^以下のブランチが存在している:$/ do |table|
  table.rows.each do |repo, branch|
    Repository.find_by_name(repo).branches.create(name:branch)
  end
end

もし /^以下のブランチを作成する:$/ do |table|
  table.rows.each do |repo, branch|
    Repository.find_by_name(repo).branches.create(name:branch)
  end
end

もし /^"(.*)"の"(.*)"ブランチから"(.*)"ブランチを作成する$/ do |repo, orig_branch, new_branch|
  orig_branch = Repository.find_by_name(repo).branches.find_by_name(orig_branch)
  new_branch = orig_branch.checkout({name:new_branch})
  new_branch.save
end



もし /^以下のポストが存在している:$/ do |table|
  table.rows.each do |repository, branch, title, body|
    branch = Repository.find_by_name(repository).branches.find_by_name(branch)
    branch.posts.create(title:title, body:body)
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
