class Kommit < ActiveRecord::Base
  attr_accessible :message, :revision

  has_many :branch_kommits, dependent: :destroy
  has_many :branches, through: :branch_kommits
  belongs_to :user
  validates :message, presence: true, length: {maximum: 30}

  def repository
    self.branches.first.repository
  end

  def info
    self.repository.repo.commits(self.revision).first
  end


end
