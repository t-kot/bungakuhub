class IssueComment < ActiveRecord::Base
  attr_accessible :author_id, :body, :issue_topic_id
  belongs_to :issue_topic
  belongs_to :author, class_name: "User"

  validates :body, presence: true
  validates :issue_topic_id, presence: true
end
