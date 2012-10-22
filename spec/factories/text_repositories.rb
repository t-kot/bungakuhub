FactoryGirl.define do
  factory :textrepo1,class: TextRepository do
    user factory: :tanaka
    repository_type_id 1
    name "Fuga"
    description "Hoge"
  end
end
