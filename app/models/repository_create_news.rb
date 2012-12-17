#coding: utf-8
class RepositoryCreateNews < News

  def body
    "#{self.user}が#{self.repository}を作成しました"
  end
end
