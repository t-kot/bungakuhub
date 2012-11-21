class Branch < ActiveRecord::Base
  attr_accessible :name, :repository_id
  belongs_to :repository
  has_many :branch_kommits, dependent: :destroy
  has_many :kommits, through: :branch_kommits, uniq: true
  has_many :posts
  validates :name, presence: true, length: {maximum: 30}
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
end
