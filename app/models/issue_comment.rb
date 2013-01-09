class IssueComment < ActiveRecord::Base
  attr_accessible :author_id, :body, :issue_topic_id
end
