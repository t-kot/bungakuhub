require 'spec_helper'

describe BranchesController do

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
      user = FactoryGirl.create(:user)
      repository = FactoryGirl.create(:text_repository, user: user)
      branches = [FactoryGirl.create(:branch, repository:repository)]
      others_branches = [FactoryGirl.create(:branch)]
      get :index, {user_id: user, repository_id: repository}, valid_session
      assigns(:branches).should eq(branches)
    end
  end

  describe "GET show" do
    it "assigns the requested branch as @branch" do
      user = FactoryGirl.create(:user)
      repository = FactoryGirl.create(:text_repository, user: user)
      branch = FactoryGirl.create(:branch, repository:repository)
      get :show, {user_id: user, repository_id: repository, :id => branch.to_param}, valid_session
      assigns(:branch).should eq(branch)
    end
  end

end
