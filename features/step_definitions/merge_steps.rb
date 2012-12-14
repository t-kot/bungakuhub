#coding: utf-8
#language: ja

もし /^"(.*)"をマージする$/ do |branch|
  select(branch, from: "merge_target")
  click_button("merge")
end
