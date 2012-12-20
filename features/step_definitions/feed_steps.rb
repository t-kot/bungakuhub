#coding: utf-8
When /^以下のツイートが存在する:$/ do |table|
  table.rows.each do |user, tweet|
    User.find_by_display_name(user).tweets.create(body:tweet)
  end
end

When /^フィードのタイムラインを表示している$/ do
  visit timeline_feeds_path
end

Then /^以下のフィードが表示されていること$/ do |table|
  table.rows.each do |feed|
    step %Q["#{feed.first}"と表示されていること]
  end
end
