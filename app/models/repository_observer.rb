class RepositoryObserver < ActiveRecord::Observer
  def before_create(repository)
    unless File.exist?("#{repository.working_dir}")
      repository.mkdir
      repository.init_readme
    end
  end
end
