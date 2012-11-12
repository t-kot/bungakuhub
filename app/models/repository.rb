require 'fileutils'
require 'grit'
class Repository < ActiveRecord::Base
  attr_accessor :repo
  attr_accessible :description, :name, :repository_type_id, :type, :user_id
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

  def init_readme
    copy_readme
    git_init
    new_file = File.open("#{self.working_dir}/README.rdoc", "w")
    new_blob = Grit::Blob.create(repo, {name:"README.rdoc", data:new_file})
    Dir.chdir(repo.working_dir){repo.add(new_blob.name)}
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

  private
  def copy_readme
    FileUtils.cp("#{Rails.root}/lib/public/README_template.rdoc",
                 "#{self.working_dir}/README.rdoc")
  end
end
