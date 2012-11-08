class KommitObserver < ActiveRecord::Observer
  def before_create(kommit)
    p kommit
    repo = kommit.repository.repo
    repo.commit_index(kommit.message)
    kommit.revision = repo.commits.first.id
  end

  def after_create(kommit)
  end
end
