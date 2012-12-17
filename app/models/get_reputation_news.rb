#coding: utf-8
class GetReputationNews < News
  def body
    "#{self.user}の#{self.repository}が評価を受けました"
  end
end
