require 'spec_helper'


describe KommitsController do

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all kommits as @kommits" do
      user = FactoryGirl.create(:user)
      repository = FactoryGirl.create(:repository, user: user)
      branch = FactoryGirl.create(:branch, repository: repository)
      branch.kommits << FactoryGirl.create(:kommit)
      get :index, {user_id:user, repository_id:repository, branch_id:branch}, valid_session
      assigns(:kommits).should eq(branch.kommits)
    end
  end

  describe "GET show" do
    it "assigns the requested kommit as @kommit" do
      user = FactoryGirl.create(:user)
      repository = FactoryGirl.create(:repository, user: user)
      branch = FactoryGirl.create(:branch, repository: repository)
      kommit =  FactoryGirl.create(:kommit)
      branch.kommits << kommit
      get :show, {:id => kommit.to_param, user_id:user, repository_id:repository, branch_id:branch}, valid_session
      assigns(:kommit).should eq(kommit)
    end
  end
end
