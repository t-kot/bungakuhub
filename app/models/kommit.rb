require 'open3'
require 'grit'
class Kommit < ActiveRecord::Base
  attr_accessor :bare, :init_at
  attr_accessible :message, :revision, :bare, :init_at

  has_many :branch_kommits, dependent: :destroy
  has_many :branches, through: :branch_kommits, uniq: true
  belongs_to :user
  validates :message, presence: true
  validates :revision, uniqueness: true


  def repository
    self.branches.first.repository
  end

  def info(branch_name=nil)
    if branch_name
      self.repository.repo.commits(branch_name).detect{|commit| commit.id == self.revision}
    else
      self.repository.repo.commits.detect{|commit| commit.id == self.revision}
    end
  end

  def revert(branch="master")
    Dir.chdir(self.repository.working_dir) do
      Open3.popen3("git checkout #{branch}") do |stdin, stdout, stderr|
        BungakuHub::Error.new(stderr).try_raise
      end
      Open3.popen3("git revert --no-edit #{self.revision}") do |stdin, stdout, stderr|
        BungakuHub::Error.new(stderr).try_raise
      end
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

  def head?(branch_name='master')
    Dir.chdir(self.repository.working_dir) do
      Open3.popen3("git rev-list #{branch_name}") do |stdin, stdout, stderr|
        BungakuHub::Error.new(stderr).try_raise
        bol = stdout.read.split("\n").first
        self.revision == bol
      end
    end
  end

  def files
    Dir.chdir(self.repository.working_dir) do
      Open3.popen3("git show #{self.revision}:./") do |stdin, stdout, stderr|
        BungakuHub::Error.new(stderr).try_raise
        files_from_string(stdout.read)
      end
    end
  end

  def inspect(name)
    Dir.chdir(self.repository.working_dir) do
      Open3.popen3("git show #{self.revision}:#{name}") do |stdin, stdout, stderr|
        BungakuHub::Error.new(stderr).try_raise
        stdout.read
      end
    end
  end

  def restore_all_files
    self.files.each do |file_name|
      body = self.inspect(file_name)
      Post.create(title:file_name, body:body)
    end
  end

  private
  def files_from_string(str)
    lines = str.split("\n")
    2.times{lines.shift}
    lines
  end





end
