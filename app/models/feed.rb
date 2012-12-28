class Feed < ActiveRecord::Base
  attr_accessible :type, :user_id, :repository_id
  belongs_to :user
  belongs_to :repository
  before_save :is_concrete_class?


  ABSTRACT_CLASS = ["News"]

  def self.followed_by(user)
    followed_ids = user.followings.map(&:id).join(",")
    where("user_id IN (#{followed_ids})
          OR user_id=:user_id", {user_id:user})
  end

  private
  def is_concrete_class?
    raise Exception.new("You cannot create abstract class instance") if ABSTRACT_CLASS.include?(self.type) || self.type.nil?
  end
end
