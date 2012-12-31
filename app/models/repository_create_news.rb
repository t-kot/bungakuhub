#coding: utf-8
class RepositoryCreateNews < News
  include Rails.application.routes.url_helpers
  include ActionView::Helpers

  def body
    linked_user = "#{link_to self.user.display_name, user_path(self.user)}"
    linked_repository = "#{link_to self.repository.name, repository_path(self.repository)}"
    {
      "ja"=>"#{linked_user}が#{linked_repository}を作成しました",
      "en"=>"#{linked_user} has created #{linked_repository}."
    }
  end
end
