#coding: utf-8
#language: ja

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


もし /^"(.*)"をマージする$/ do |branch|
  select(branch, from: "merge_target")
  click_button("merge")
end

もし /^レポジトリタイプ"(.*)",レポジトリ名"(.*)"の"(.*)"レポジトリを作成する$/ do |setting, name, type|
  if type=="テキスト"
    click_link("テキストレポジトリ")
  else
    raise "#{type}というレポジトリはありません"
  end
  setting=="公開" ? choose("text_repository_repository_type_id_1") : choose("text_repository_repository_type_id_2")
  fill_in("レポジトリ名", with: name)
  click_button("作成")
end

ならば /^テキストレポジトリが作成されていること$/ do
  step %Q["テキストレポジトリが作成されました"と表示されていること]
end
