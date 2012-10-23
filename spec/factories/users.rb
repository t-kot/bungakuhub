FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@example.com"}
    first_name "First"
    last_name "Last"
    password "testtest"
    password_confirmation "testtest"

    after(:create){|user| user.confirm! }
  end
end
FactoryGirl.define do
  factory :tanaka, class: User do
    display_name "Tanaka"
    first_name "tanaka"
    last_name "kakuei"
    email "tanaka@kakuei.com"
    password "tanaka"
    confirmed_at Time.now
  end
  factory :takeshita, class: User do
    display_name "Takeshita"
    first_name "Takeshita"
    last_name "Noboru"
    email "takeshita@noboru.com"
    password "password"
    confirmed_at Time.now
  end
  factory :sample1, class: User do
    display_name "Other"
    first_name "Other"
    last_name "Other"
    email "other@other.com"
    password "other"
    confirmed_at Time.now
  end
end
