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

