#coding: utf-8
class RepositoryReputateNews < News

  def body
    "#{self.user}が#{self.repository}をいいね！と言っています"
  end
end
