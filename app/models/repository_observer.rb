class RepositoryObserver < ActiveRecord::Observer
  observe Repository, TextRepository
  def before_create(repository)
    unless Rails.env.test?
      repository.mkdir
      repository.init_readme
    end
  end
end
