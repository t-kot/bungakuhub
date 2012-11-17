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
    
    after(:create){|user| user.confirm! }
  end

  factory :branch do
    sequence(:name) {|n| "Branch#{n}"}
    repository
  end
  factory :kommit do
    sequence(:message) {|n| "Commit Message #{n}"}
  end
  factory :post do
    sequence(:title) {|n| "Title#{n}"}
    sequence(:body) {|n| "Post body #{n}"}
    branch
  end
end
