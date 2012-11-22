class BranchObserver < ActiveRecord::Observer

  def before_create(branch)
    git_checkout_b(branch)
  end


  private
  def git_checkout_b(branch)
    branch.repository.repo.git.native :stash
    branch.repository.repo.git.native :checkout, {b: true}, branch.name
  end
end
