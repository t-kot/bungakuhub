class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  default_scope where(hidden:false)
  attr_accessible :email, :password, :password_confirmation, :remember_me, :display_name, :first_name, :last_name,:sex_id, :hidden, :facebook_uid, :twitter_uid, :google_uid

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
                            email: true

  def self.find_for_facebook_oauth(auth)
     User.find_by_facebook_uid(auth.uid)
  end
  def self.find_for_twitter_oauth(auth)
    User.find_by_twitter_uid(auth.uid)
  end
  def self.find_for_google_oauth(auth)
    User.find_by_google_uid(auth.uid)
  end

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

  def self.new_with_facebook_session(params, session)
    data = session["devise.facebook_data"]
    #user = User.new(params, facebook_uid:session["devise.facebook_uid"],
    #         email: data["info"]["email"])
    user = User.new(params)
    user.facebook_uid = session["devise.facebook_uid"]
    user.email = data["info"]["email"]
    user.password = Devise.friendly_token[0, 20]
    user
  end

  def self.new_with_twitter_session(params, session)
    data = session["devise.twitter_data"]
    user = User.new(params)
    user.twitter_uid = data[:uid]
    user.password = Devise.friendly_token[0, 20]
    user
  end

  def self.new_with_google_session(params, session)
    data = session["devise.google_data"]
    user = User.new(params)
    user.google_uid = data[:uid]
    user.email = data[:email]
    user.password = Devise.friendly_token[0, 20]
    user
  end

  def facebook_connected?
    self.facebook_uid.present?
  end

  def twitter_connected?
    self.twitter_uid.present?
  end

  def google_connected?
    self.google_uid.present?
  end

end
