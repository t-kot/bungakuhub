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

  def lock(&block)
    Timeout::timeout(10) do
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
    raise AccessDenied.new('timeout')
  end

  def checkout_master
    self.checkout_to("master")
  end

  def checkout_to(branch_name)
    self.repo.create_stash
    self.repo.checkout_to(branch_name)
    self.repo.pop_first_at(branch_name)
    self.repo.stashes(branch_name).each(&:destroy)
  end

end
