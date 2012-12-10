#coding: utf-8
#language: ja

もし /^以下のポストが存在している:$/ do |table|
  table.rows.each do |repository, branch, title, body|
    branch = Repository.find_by_name(repository).branches.find_by_name(branch)
    branch.repository.lock do
      branch.repository.checkout_to(branch.name)
      branch.posts.create(title:title, body:body)
      branch.repository.checkout_master
    end
  end
end

もし /^タイトルが"(.*?)"で本文が"(.*?)"のポストを作成する$/ do |title, body|
  within("#new_post") do
    step %Q["タイトル"に"#{title}"と入力する]
    step %Q["本文"に"#{body}"と入力する]
    click_button("Save")
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
    click_button("Save")
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
