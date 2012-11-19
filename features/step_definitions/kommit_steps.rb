#coding: utf-8
#language: ja

もし /^タイトルが"(.*?)",本文が"(.*?)"のポストを入力する$/ do |title, body|
  fill_in "post_title", with: title
  fill_in "post_body", with: body
end

もし /^"(.*?)"をコミット$/ do |message|
  fill_in "kommit_message", with: message
  click_button("Save")
end
