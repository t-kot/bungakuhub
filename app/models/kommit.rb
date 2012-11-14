class Kommit < ActiveRecord::Base
  attr_accessor :skip_callback
  attr_accessible :message, :revision, :skip_callback

  has_many :branch_kommits, dependent: :destroy
  has_many :branches, through: :branch_kommits
  belongs_to :user
  validates :message, presence: true

  def repository
    self.branches.first.repository
  end

  def info
    self.repository.repo.commits(self.revision).first
  end


end
