#coding: utf-8
#language: ja

もし /^以下のポストが存在している:$/ do |table|
  table.rows.each do |repository, branch, title, body|
    step %Q["#{repository}"の"#{branch}"ブランチにタイトルが"#{title}"で本文が"#{body}"のポストを作成する]
  end
end

もし /^"(.*?)"の"(.*?)"ブランチにタイトルが"(.*?)"で本文が"(.*?)"のポストを作成する$/ do |repo, branch, title, body|
  repository = Repository.find_by_name(repo)
  branch = repository.branches.find_by_name(branch)
  repository.lock do
    repository.checkout_to(branch.name)
    branch.posts.create(title:title, body:body)
    repository.checkout_master
  end
end

もし /^"(.*?)"の"(.*?)"ブランチのポストを以下のように編集する:$/ do |repo, branch, table|
  table.rows.each do |title_before, title_after, body|
    repository = Repository.find_by_name(repo)
    branch = repository.branches.find_by_name(branch)
    repository.lock do
      repository.checkout_to(branch.name)
      post = Post.find_by_title(title_before)
      post.update_attributes(title:title_after, body: body)
      repository.checkout_master
    end
  end
end

もし /^タイトルが"(.*?)"で本文が"(.*?)"のポストを作成する$/ do |title, body|
  within("#new_post") do
    step %Q["タイトル"に"#{title}"と入力する]
    step %Q["本文"に"#{body}"と入力する]
    click_button("作成")
  end
end

もし /^"(.*?)"の(.*)を"(.*?)"に更新する$/ do |title, target, update_value|
  form_id = find(:xpath, "//input[@value='#{title}']/../..")[:id]
  within("##{form_id}") do
    case target
    when "タイトル"
      step %Q["タイトル"に"#{update_value}"と入力する]
    when "本文"
      step %Q["本文"に"#{update_value}"と入力する]
    end
    click_button("更新")
  end
end

ならば /^ポストが作成されること$/ do
  step %Q["ポストが作成されました"と表示されていること]
end

ならば /^ポストの作成に失敗すること$/ do
  step %Q["ポストは保存されませんでした"と表示されていること]
end

ならば /^ポストの更新に成功すること$/ do
  step %Q["ポストが更新されました"と表示されていること]
end

ならば /^ポストの更新に失敗すること$/ do
  step %Q[ポストの作成に失敗すること]
end
