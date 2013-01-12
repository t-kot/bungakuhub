class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  default_scope where(hidden:false)
  attr_accessible :email, :password, :password_confirmation, :remember_me, :display_name, :first_name, :last_name,:sex_id, :hidden

  belongs_to :sex
  has_many :text_repositories
  has_many :repositories
  has_many :kommits
  has_many :following_ships, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :following_ships, class_name: "User"
  has_many :inverse_following_ships, foreign_key: :following_id, class_name: "FollowingShip", dependent: :destroy
  has_many :followers, through: :inverse_following_ships, class_name: "User"
  has_many :feeds, dependent: :destroy
  has_many :news
  has_many :tweets
  has_many :repository_create_news
  has_many :repository_update_news
  has_many :issue_topics, dependent: :destroy, foreign_key: :author_id
  has_many :issue_comments, dependent: :destroy, foreign_key: :author_id


  validates :display_name,  presence: true, length: {maximum:30},
                            uniqueness: true
  validates :email,         length: {maximum:50},
                            uniqueness: true, email: true

  def full_name
    self.first_name+" "+self.last_name
  end

  def follow!(user)
    self.followings << user
  end

  def unfollow!(user)
    self.following_ships.find(:first, conditions: {follower_id:self, following_id:user}).destroy
  end

  def follows?(user)
    self.followings.include?(user)
  end

  def hide
    self.update_attributes(hidden:true)
  end

  def recover
    self.update_attributes(hidden:false)
  end

end
