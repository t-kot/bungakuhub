module FactoryHelpers

  def create_repository_for(user)
    @repository = FactoryGirl.create(:repository, user: user)
  end

  def create_text_repository_for(user)
    @repository = FactoryGirl.create(:text_repository, user: user)
  end

  def create_branch_for(user)
    create_repository_for(user)
    @branch = FactoryGirl.create(:branch, repository: @repository)
  end

  def create_post_and_kommit_for(branch)
    branch.repository.lock do
      branch.repository.checkout_to(branch.name)
      create(:post, branch:branch)
      branch.build_kommit(message:"hoge#{branch.id}").save
      branch.repository.checkout_master
    end
  end


end
