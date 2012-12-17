#coding: utf-8
class StartFollowNews < News
  def body
    "#{self.user}が#{self.target_user}をフォローしました"
  end
end
