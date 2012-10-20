# coding:utf-8

もし /^ユーザ名が"(.*?)"のユーザがいる$/ do |user|
  FactoryGirl.create(:tanaka).confirm!
end
