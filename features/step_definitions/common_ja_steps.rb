# coding: utf-8
#language: ja

もし /言語は"(.*)"を選択/ do |language|
  visit "?locale=#{language}"
end

ならば /^ログインを要求すること$/ do
  step %Q["ログインしてください"と表示されていること]
end

ならば /^許可されていないアクションであること$/ do
  step %Q["許可されていないアクションです"と表示されていること]
end

