#coding: utf-8
#language: ja

もし /^タイトルが"(.*?)",本文が"(.*?)"のポストを作成する$/ do |title, body|
  within("#new_post") do
    fill_in "post_title", with: title
    fill_in "post_body", with: body
    click_button("Save")
  end
end

もし /^"(.*?)"をコミット$/ do |message|
  fill_in "kommit_message", with: message
  click_button("Save")
end

もし /^以下のコミットが存在している:$/ do |table|
  table.rows.each do |repository, branch, msg|
    branch = Repository.find_by_name(repository).branches.find_by_name(branch)
    branch.repository.lock do
      branch.repository.checkout_to(branch.name)
      FactoryGirl.create(:post, branch:branch)
      branch.build_kommit(message:msg).save
      branch.repository.checkout_master
    end
  end
end


ならば /^(.*?)の(.*?)ブランチに(.*?)コミットが存在すること$/ do |repo, branch, commit|
  step %Q["#{repo}の#{branch}ブランチのコミット一覧ページ"へアクセス]
  step %Q["#{commit}"コミットが存在すること]

end

ならば /^"(.*)"コミットが存在すること$/ do |kommit|
  step %Q["#{kommit}"と表示されていること]
end

ならば /^ステータスで"(.*)"が(.*)されていること$/ do |title, action|
  case action
  when "追加" then field = "#added_post"
  when "削除" then field = "#deleted_post"
  when "更新" then field = "#updated_post"
  else
    raise "#{action}にあたるアクションが見つかりません"
  end
  within(field) do
    step %Q["#{title}"と表示されていること]
  end
end

ならば /^コミットの必要がないこと$/ do
  step %Q["コミットする必要はありません"と表示されていること]
end

ならば /^一度コミットを要求すること$/ do
  step %Q["現在の変更を一度コミットする必要があります"と表示されていること]
end
