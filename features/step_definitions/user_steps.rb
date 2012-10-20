# coding:utf-8

もし /^ユーザ名が"(.*?)"のユーザがいる$/ do |user|
  User.create(display_name: "user1", first_name: "tanaka", last_name: "kakuei", 
              email: "tanaka@kakuei.com", password: "tanaka")
end
