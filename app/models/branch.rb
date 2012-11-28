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

  def post_initialize
    repo = self.repository.repo
    repo.commits.first.tree.contents.each do |content|
      self.posts.create(title:content.name, body:content.data, bare:true)
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

  def create_kommit(params)
    kommit = Kommit.new(params)
    kommit.branches << self
    kommit.init_at = self
    kommit
  end


end
