#coding: utf-8
#language: ja

When /^以下のフォロー関係が成立している:$/ do |table|
  table.rows.each do |follower, following|
    user = User.find_by_display_name(follower)
    target = User.find_by_display_name(following)
    user.follow!(target)
  end
end

Then /^以下のユーザが一覧に表示されていること:$/ do |table|
  table.rows.each do |user_name|
    step %Q["#{user_name.first}"と表示されていること]
  end
end
