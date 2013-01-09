class IssueTopic < ActiveRecord::Base
  attr_accessible :author_id, :body, :open, :title
end
