#coding: utf-8
class RepositoryForkedNews < News
  def body
    "#{self.user}が#{self.repository}をフォークしました"
  end
end
