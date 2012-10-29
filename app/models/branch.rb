class Branch < ActiveRecord::Base
  attr_accessible :name, :repository_id
  belongs_to :repository
  validates :name, presence: true, length: {maximum: 30}
end
