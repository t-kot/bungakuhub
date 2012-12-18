class Feed < ActiveRecord::Base
  attr_accessible :type, :user_id
  belongs_to :user

  def self.followed_by(user)
    followed_ids = user.followings.map(&:id).join(",")
    where("user_id IN (#{followed_ids})
          OR user_id=:user_id", {user_id:user})
  end
end
