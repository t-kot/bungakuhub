class BranchObserver < ActiveRecord::Observer

  def before_create(branch)
    git_checkout_b(branch) unless branch.bare
  end

  def after_create(branch)
    branch.post_initialize unless branch.bare
  end


  private
  def git_checkout_b(branch)
    branch.repository.repo.create_branch(branch.name)
    branch.repository.checkout_to(branch.name)
  end
end
