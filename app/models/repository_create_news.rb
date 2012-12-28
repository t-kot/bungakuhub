#coding: utf-8
class RepositoryCreateNews < News

  def body
    "#{self.user.display_name}が「#{self.repository.name}」を作成しました"
  end
end
