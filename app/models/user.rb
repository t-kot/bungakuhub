class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :sex
  has_many :text_repositories
  has_many :repositories
  has_many :kommits
  has_many :following_ships, foreign_key: :follower_id
  has_many :followings, through: :following_ships, class_name: "User"
  has_many :inverse_following_ships, foreign_key: :following_id, class_name: "FollowingShip"
  has_many :followers, through: :inverse_following_ships, class_name: "User"
  has_many :feeds
  has_many :news
  has_many :tweets
  has_many :repository_create_news

  attr_accessible :email, :password, :password_confirmation, :remember_me, :display_name, :first_name, :last_name,:sex_id

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

end
