#coding: utf-8
class RepositoryUpdateNews < News

  def body
    "#{self.user}が#{self.repository}を更新しました"
  end
end
