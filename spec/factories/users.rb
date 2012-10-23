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
end
