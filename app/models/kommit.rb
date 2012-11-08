class Kommit < ActiveRecord::Base
  attr_accessible :message, :revision

  has_many :branch_kommits, dependent: :destroy
  has_many :branches, through: :branch_kommits
  accepts_nested_attributes_for :branch_kommits

  validates :message, presence: true, length: {maximum: 30}
end
