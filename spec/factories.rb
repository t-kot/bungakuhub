FactoryGirl.define do
  factory :repository  do
    user
    type "TextRepository"
    sequence(:name) {|n|  "TextRepo#{n}"}
    repository_type_id 1
    description "Created by factory_girl"
  end
  factory :text_repository , parent: :repository do
    type "TextRepository"
  end
  factory :user do
    sequence(:email) {|n| "email#{n}@example.com"}
    sequence(:display_name) {|n| "User#{n}"}
    first_name "First"
    last_name "Last"
    password "testtest"
    password_confirmation "testtest"
    
    factory :user_with_text_repositories do
      ignore do
        text_repositories_count 5
      end
      after(:create) do |user,evaluator|
        FactoryGirl.create_list(:text_repository, evaluator.text_repositories_count,user: user)
      end
    end


    after(:create){|user| user.confirm! }
  end

  factory :branch do
    sequence(:name) {|n| "Branch#{n}"}
    repository
  end
end
