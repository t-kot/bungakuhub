class KommitObserver < ActiveRecord::Observer
  def before_create(kommit)
    set_revision(kommit) unless kommit.bare
  end

  def after_create(kommit)
    return if kommit.bare
  end

  private
  def set_revision(kommit)
    Dir.chdir(kommit.repository.working_dir) do
      `git commit -m "#{kommit.message}"`
    end
    kommit.revision = kommit.init_at.try(:head) || kommit.repository.master.head
  rescue Exception => ex
    p ex
    raise Exception.new('cannot set revision')
  end
end
