#coding: utf-8
class RepositoryCreateNews < News
  belongs_to :user

  def body
    "#{self.user}が#{self.repository}を作成しました"
  end
end
