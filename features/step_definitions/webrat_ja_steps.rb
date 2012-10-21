# coding: utf-8
# Commonly used webrat steps
# http://github.com/brynary/webrat


もし /言語は"(.*)"/ do |lang|
  header("ACCEPT_LANGUAGE", lang)
end

もし /^"(.*)"ボタンをクリックする$/ do |button|
  click_button(button)
end

もし /^"(.*)"リンクをクリックする$/ do |link|
  click_link(link)
end

もし /再読み込みする/ do
  visit request.request_uri
end

もし /^"(.*)"に"(.*)"と入力する$/ do |field, value|
  fill_in(field, :with => value)
end

# opposite order from Engilsh one(original)
もし /^"(.*)"から"(.*)"を選択$/ do |field, value|
  select(value, :from => field)
end

もし /^"(.*)"をチェックする$/ do |field|
  check(field)
end

もし /^"(.*)"のチェックを外す$/ do |field|
  uncheck(field)
end

もし /^"(.*)"を選択する$/ do |field|
  choose(field)
end

# opposite order from Engilsh one(original)
もし /^"(.*)"としてをファイル"(.*)"を添付する$/ do |field, path|
  attach_file(field, path)
end

もし /^"(.*)"へアクセス$/ do |page_name|
  visit path_to(page_name)
end

When /^"(.*)"と表示されていること$/ do |content|
  page.body.should =~ /#{Regexp.escape(content)}/m
end

Then /^"(.*)"と表示されていないこと$/ do |content|
  #page.body.should_not =~ /#{text}/m
  page.body.should_not =~ /#{Regexp.escape(content)}/m
end

ならば /^"(.*)"がチェックされていること$/ do |label|
  field_labeled(label).should be_checked
end
