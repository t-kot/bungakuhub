require 'spec_helper'

describe BranchesController do
  before(:each) do
    @user = create(:user)
    create_branch_for(@user)
  end
  after(:each) do
    @repository.destroy
  end

  def valid_attributes
    {
      name: "Branch1"
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all branches as @branches" do
      branches = @repository.branches
      get :index, {user_id: @user, repository_id: @repository}, valid_session
      assigns(:branches).should eq(branches)
    end
  end

  describe "GET show" do
    it "assigns the requested branch as @branch" do
      get :show, {user_id: @user, repository_id: @repository, :id => @branch.to_param}, valid_session
      assigns(:branch).should eq(@branch)
    end
  end

end
