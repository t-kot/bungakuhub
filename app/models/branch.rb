class Branch < ActiveRecord::Base
  attr_accessible :name, :repository_id
  belongs_to :repository
end
