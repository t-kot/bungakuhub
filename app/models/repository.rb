require 'fileutils'
require 'grit'
class Repository < ActiveRecord::Base
  attr_accessor :repo, :bare
  attr_accessible :description, :name, :repository_type_id, :type, :user_id, :bare
  belongs_to :repository_type
  belongs_to :user
  has_many :branches

  validates :name,  presence: true, length: {maximum:30}, uniqueness: true

  def owner
    self.user
  end
  def owner=(arg)
    self.user=(arg)
  end
  def original?
    self.forked_from.nil?
  end
  def forked?
    self.forked_from.present?
  end

  def mkdir
    Dir::mkdir("#{Rails.root}/public/repositories/#{self.name}/")
  end


  def working_dir
    "#{Rails.root}/public/repositories/#{self.name}"
  end


  def repo
    Grit::Repo.new("#{self.working_dir}")
  end

  def git_init
    repo = Grit::Repo.init("#{self.working_dir}/")
  end

  def master
    self.branches.find_by_name("master")
  end

  def status
    self.repo.status
  end

end
