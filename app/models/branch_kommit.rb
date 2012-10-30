class BranchKommit < ActiveRecord::Base
  belongs_to :kommit
  belongs_to :branch
  attr_accessible :kommit_id, :branch_id
end
