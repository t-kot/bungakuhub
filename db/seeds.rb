YAML.load_file('db/data/sex.yml').each{|sex| Sex.create!(sex)}
YAML.load_file('db/data/language.yml').each{|language| Language.create!(language)}
YAML.load_file('db/data/repository_type.yml').each{|repository| RepositoryType.create!(repository)}
YAML.load_file('db/data/text_category.yml').each{|c| TextCategory.create!(c)}

if Rails.env.development?
  YAML.load_file('db/data/user.yml').each{|user| User.create!(user).confirm!}
end
