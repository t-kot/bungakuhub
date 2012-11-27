class KommitObserver < ActiveRecord::Observer
  def before_create(kommit)
    set_revision(kommit) unless kommit.bare
  end

  def after_create(kommit)
    return if kommit.bare
  end

  private
  def set_revision(kommit)
    repo = kommit.repository.repo
    #repo.commit_index(kommit.message)
    Dir.chdir(repo.working_dir) do
      `git commit -m "#{kommit.message}"`
      branch_name = kommit.init_at.try(:name) ||  "master"
      output = `git rev-list #{branch_name}`
      newest_revision = output.split("\n").first
      kommit.revision = newest_revision
    end
  rescue Exception => ex
    p ex
    raise Exception.new('cannot set revision')
  end
end
