class BranchKommit < ActiveRecord::Base
  belongs_to :kommit
  accepts_nested_attributes_for :kommit
  belongs_to :branch
  accepts_nested_attributes_for :branch
  attr_accessible :kommit_id, :branch_id
end
