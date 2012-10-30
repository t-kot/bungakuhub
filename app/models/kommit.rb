class Kommit < ActiveRecord::Base
  attr_accessible :message, :revision

  has_many :branch_kommits, dependent: :destroy
  has_many :branches, through: :branch_kommits
end
