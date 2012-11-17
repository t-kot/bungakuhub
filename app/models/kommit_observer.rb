class KommitObserver < ActiveRecord::Observer
  def before_create(kommit)
    return if kommit.bare
    set_revision(kommit)
  end

  def after_create(kommit)
    return if kommit.bare
  end

  private
  def set_revision(kommit)
    repo = kommit.repository.repo
    repo.commit_index(kommit.message)
    kommit.revision = Grit::Head.current(repo).commit.id
  end
end
