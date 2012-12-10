class Branch < ActiveRecord::Base
  attr_accessor :bare
  attr_accessible :name, :repository_id, :bare
  belongs_to :repository
  has_many :branch_kommits, dependent: :destroy
  has_many :kommits, through: :branch_kommits, uniq: true
  has_many :posts
  validates :name, presence: true, length: {maximum:30},
            uniqueness: {scope: :repository_id}

  delegate :status, to: :repository
  delegate :current_files, to: :repository
  def destroy_all_post
    self.posts.each{|post| post.bare = true}
    self.posts.destroy_all
  end

  def create_bare_post_for(kommit)
    kommit.contents.each do |content|
      title = content.name.force_encoding("UTF-8").split(".").first
      self.posts.create(bare: true,
                          title: title,
                          body: content.data.force_encoding("UTF-8"))
    end
  end

  def create_posts_by_current_file
    Dir.chdir(self.repository.working_dir) do
      current_files.each do |file|
        File.open(file, "r") do |f|
          self.posts.create(title:file, body:f.read, bare:true)
        end
      end
    end
  end

  def original
    Branch.find(self.original_id) if self.original_id
  end

  def checkout(params)
    branch = Branch.new(params)
    branch.original_id = self.id
    branch.repository = self.repository
    branch
  end


  def rev_list
    Dir.chdir(self.repository.working_dir) do
      output = `git rev-list #{self.name}`
      output.split("\n")
    end
  end

  def head
    self.rev_list.first
  end

  def build_kommit(params)
    kommit = Kommit.new(params)
    kommit.branches << self
    kommit.init_at = self
    kommit
  end

  def nothing_to_commit?
    repository = self.repository
    bool=nil
    repository.lock do
      repository.checkout_to(self.name)
      bool = self.status.added.blank? && self.status.deleted.blank? && self.status.changed.blank?
      repository.checkout_master
    end
    bool
  end

  def merge(merged_branch)
    if merged_branch.nothing_to_commit? && self.nothing_to_commit?
      output=nil
      Dir.chdir(self.repository.working_dir) do
        output = `git merge --no-ff --no-edit #{merged_branch.name}`
      end
      result = output.split("\n").first
      self.destroy_all_post
      create_posts_by_current_file
      if /^Merge (.*) strategy.$/.match result
        self.build_kommit(message:"Merge branch #{merged_branch.name}", revision: head).save
      end
      self
    else
      false
    end
  end

  def destroyable?
    self.name != "master"
  end

  def git_branch_d
    Dir.chdir(self.repository.working_dir) do
      `git branch -d #{self.name}`
    end
  end


end
