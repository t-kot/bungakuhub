require 'grit'
class Kommit < ActiveRecord::Base
  attr_accessor :bare, :init_at
  attr_accessible :message, :revision, :bare, :init_at

  has_many :branch_kommits, dependent: :destroy
  has_many :branches, through: :branch_kommits, uniq: true
  belongs_to :user
  validates :message, presence: true


  def repository
    self.branches.first.repository
  end

  def info
    self.repository.repo.commits.detect{|commit| commit.id == self.revision}
  end

  def revert(branch="master")
    Dir.chdir(self.repository.working_dir) do
      `git checkout #{branch}"`
      `git revert --no-edit #{self.revision}`
    end
  end

  def git_message
    self.info.message.force_encoding("UTF-8")
  end

  def git_revision
    self.info.id
  end

  def contents
    self.info.tree.contents
  end

  def head?(branch='master')
    Dir.chdir(self.repository.working_dir) do
      output = `git rev-list #{branch}`
      newest_revision = output.split("\n").first
      self.revision == newest_revision
    end
  end



end
