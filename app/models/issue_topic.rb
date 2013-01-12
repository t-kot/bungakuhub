class IssueTopic < ActiveRecord::Base
  attr_accessible :author_id, :body, :open, :title
  belongs_to :author, class_name: "User"
  belongs_to :repository
  has_many :issue_comments, dependent: :destroy
  validates :body, presence: true
  validates :title, presence: true
end
