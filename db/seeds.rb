YAML.load_file('db/data/sex.yml').each{|sex| Sex.create!(sex)}

if Rails.env.development?
  YAML.load_file('db/data/user.yml').each{|user| User.create!(user)}
end
