require 'spec_helper'

describe BranchObserver do
  before(:each) do
    user = create(:user)
    create_repository_for(user)
    @another = @repository.master.checkout(name:"another")
    @another.save
  end

  it "should callback git_branch_d" do
    @another.should_receive(:git_branch_d)
    @another.destroy
  end
end
