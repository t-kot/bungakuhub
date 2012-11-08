class Branch < ActiveRecord::Base
  attr_accessible :name, :repository_id
  belongs_to :repository
  has_many :branch_kommits, dependent: :destroy
  has_many :kommits, through: :branch_kommits
  has_many :posts
  validates :name, presence: true, length: {maximum: 30}
end
