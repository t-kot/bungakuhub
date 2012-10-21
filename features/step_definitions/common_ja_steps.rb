# coding: utf-8
#language: ja

もし /言語は"(.*)"を選択/ do |language|
  visit "?locale=#{language}"
end
