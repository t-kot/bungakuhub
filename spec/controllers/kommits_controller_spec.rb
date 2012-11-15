require 'spec_helper'


describe KommitsController do

  after(:each) do
    @repository.destroy
  end

  def valid_attributes
    {
    skip_callback:true,
    message:"test",
    revision:"Test"
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all kommits as @kommits" do
      user = FactoryGirl.create(:user)
      create_branch_for(user)
      @branch.kommits.create valid_attributes
      
      get :index, {user_id:user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommits).should eq(@branch.kommits)
    end
  end

  describe "GET show" do
    it "assigns the requested kommit as @kommit" do
      user = FactoryGirl.create(:user)
      create_branch_for(user)
      kommit = @branch.kommits.create valid_attributes
      get :show, {:id => kommit.to_param, user_id:user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommit).should eq(kommit)
    end
  end
end
