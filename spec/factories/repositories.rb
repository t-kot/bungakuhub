FactoryGirl.define do
  factory :repo1, class: Repository do 
    type "Hoge"
    description "Fuga"
    user factory: :tanaka
    repository_type_id 1
  end
end

