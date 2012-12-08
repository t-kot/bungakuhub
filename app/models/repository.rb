require 'fileutils'
require 'grit'
class Repository < ActiveRecord::Base
  attr_accessor :repo, :bare
  attr_accessible :description, :name, :repository_type_id, :type, :user_id, :bare
  belongs_to :repository_type
  belongs_to :user
  has_many :branches

  validates :name,  presence: true, length: {maximum:30}, uniqueness: true

  def current_files
    Dir.entries(self.working_dir) - [".", "..", ".git"]
  end



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
    Grit::Repo.init("#{self.working_dir}/")
  end

  def master
    self.branches.find_by_name("master")
  end

  def status
    self.repo.status
  end

  def lock(&block)
    Timeout::timeout(30) do
      Dir.chdir(self.working_dir) do
        File.open(".lock", "w") do |f|
          begin
            f.flock(File::LOCK_EX)
            block.call
          ensure
            f.flock(File::LOCK_UN)
            File.unlink(f)
          end
        end
      end
    end
  rescue Exception => ex
    raise ex
    #raise AccessDenied.new('timeout')
  end

  def checkout_master
    self.checkout_to("master")
  end

  def checkout_to(branch_name)
    unless self.current_branch == branch_name
      make_current_repository_checkoutable unless nothing_to_commit?
      self.repo.checkout_to(branch_name)
      if self.repo.stashes(branch_name).present?
        self.repo.pop_first_at(branch_name)
        #restoreしたあとにstashは存在してはいけない
        #self.repo.add_all
        self.repo.add_u
        self.repo.stashes(branch_name).each(&:destroy)
      end
    end
  end

  def make_current_repository_checkoutable
    self.repo.create_stash unless nothing_to_commit?
  end


  def current_branch
    Dir.chdir(self.working_dir) do
      `git rev-parse --abbrev-ref HEAD`.chomp
    end
  end

  def nothing_to_commit?
    self.status.added.blank? && self.status.deleted.blank? && self.status.changed.blank?
  end



end
