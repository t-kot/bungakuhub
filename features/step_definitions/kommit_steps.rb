#coding: utf-8
#language: ja


もし /^"(.*)"の"(.*)"ブランチを"(.*)"というメッセージでコミットする$/ do |repo, branch, message|
  repository = Repository.find_by_name(repo)
  branch = repository.branches.find_by_name(branch)
  repository.lock do
    repository.checkout_to(branch.name)
    branch.build_kommit(message:message).save
    repository.checkout_master
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

ならば /^(.*?)の(.*?)ブランチに(.*?)コミットが存在しないこと$/ do |repo, branch, commit|
  step %Q["#{repo}の#{branch}ブランチのコミット一覧ページ"へアクセス]
  step %Q["#{commit}"コミットが存在しないこと]
end

ならば /^"(.*)"コミットが存在すること$/ do |kommit|
  step %Q["#{kommit}"と表示されていること]
end

ならば /^"(.*)"コミットが存在しないこと$/ do |kommit|
  step %Q["#{kommit}"と表示されていないこと]
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
