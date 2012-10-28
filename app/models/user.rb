class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :sex
  has_many :text_repositories
  has_many :repositories

  attr_accessible :email, :password, :password_confirmation, :remember_me, :display_name, :first_name, :last_name,:sex_id

  validates :display_name,  presence: true, length: {maximum:30},
                            uniqueness: true
  validates :email,         length: {maximum:50},
                            uniqueness: true, email: true

  def full_name
    self.first_name+" "+self.last_name
  end
end
