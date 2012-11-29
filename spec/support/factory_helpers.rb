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

  def create_post_and_kommit_for(repository)
    create(:post, branch:repository.master)
    repository.master.create_kommit(message:"hogehoge").save
  end

end
