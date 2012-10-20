FactoryGirl.define do
  factory :user do
    display_name "MyString"
    first_name "MyString"
    last_name "MyString"
    email "MyString"
  end
  factory :tanaka do
    display_name "Tanaka"
    first_name "tanaka"
    last_name "kakuei"
    email "tanaka@kakuei.com"
    password "tanaka"
  end
end
