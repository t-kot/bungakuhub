require 'grit'
class Repository < ActiveRecord::Base
  attr_reader :repo
  attr_accessible :description, :name, :repository_type_id, :type, :user_id
  belongs_to :repository_type
  belongs_to :user
  has_many :branches

  validates :name,  presence: true, length: {maximum:30}

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
    Dir::mkdir("#{self.working_dir}/")
    @repo = Grit::Repo.init("#{self.working_dir}/")
  end

  def init_readme
    new_file = File.new("#{self.working_dir}/README", "w")
    new_blob = Grit::Blob.create(@repo, {name:"README", data:new_file})
    Dir.chdir(@repo.working_dir){@repo.add(new_blob.name)}
    @repo.commit_index("First Commit")
  end

  def working_dir
    "#{Rails.root}/public/repositories/#{self.name}"
  end

  def repo
    Grit::Repo.new("#{self.working_dir}")
  end
end
