class TextRepository < Repository
  attr_accessible :description, :name, :repository_type_id, :string, :text, :owner_id
  belongs_to :user
end