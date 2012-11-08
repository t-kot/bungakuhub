require 'grit'
class RepositoryObserver < ActiveRecord::Observer
  observe Repository, TextRepository
  def before_create(repository)
    unless File.exist?("#{repository.working_dir}")
      repository.mkdir
    end
  end

  def after_create(repository)
    branch = repository.branches.create(name:"master")
    repository.init_readme
    kommit = Kommit.new(message:"First Commit(README)")
    kommit.branches << branch
    kommit.save
  end
end
