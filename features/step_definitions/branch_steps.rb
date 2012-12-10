#coding: utf-8
#language: ja

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

もし /^"(.*)"という名前でブランチを作成する$/ do |name|
  fill_in "ブランチ名", with: name
  click_button("Save")
end

ならば /^"(.*)"ブランチが存在すること$/ do |branch_name|
  step %Q["#{branch_name}"と表示されていること]
end

ならば /^正常にブランチが作成されていること$/ do
  step %Q["ブランチが作成されました"と表示されていること]
end
