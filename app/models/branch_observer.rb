class BranchObserver < ActiveRecord::Observer

  #createはcheckoutのときしか呼ばれないことに注意
  #なぜならmasterの作成時はbare=trueされるため
  def before_create(branch)
    git_branch_create(branch) unless branch.bare
  end

  def after_create(branch)
    #branch.post_initialize unless branch.bare
    branch.create_posts_by_current_file unless branch.bare
  end


  private
  def git_branch_create(branch)
    branch.repository.repo.create_branch(branch.name)
    #branch.repository.checkout_to(branch.name)
  end
end
