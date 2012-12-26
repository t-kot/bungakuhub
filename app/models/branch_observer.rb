class BranchObserver < ActiveRecord::Observer

  #createはcheckoutのときしか呼ばれないことに注意
  #なぜならmasterの作成時はbare=trueされるため
  def before_create(branch)
    git_branch_create(branch) unless branch.bare
  end

  def after_create(branch)
    ##TODO master以外からのチェックアウトのことを考えよ
    branch.enter{branch.create_posts_by_current_file} unless branch.bare
  end

  def before_destroy(branch)
    branch.git_branch_d
  end


  private
  def git_branch_create(branch)
    branch.repository.repo.create_branch(branch.name)
  end
end
