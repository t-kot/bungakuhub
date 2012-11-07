class RepositoryObserver < ActiveRecord::Observer
  observe Repository, TextRepository
  def before_create(repository)
    unless File.exist?("#{repository.working_dir}")
      repository.mkdir
      repository.init_readme
    end
  end
end
