require 'spec_helper'
describe Admin::KommitsController do

  def valid_attributes
    {
      message:"First commit"
    }
  end
  def valid_session;{};end


  describe "GET index" do
    login_user
    it "assigns all kommits as @kommits" do
      create_branch_for(@current_user)
      @branch.kommits << FactoryGirl.create(:kommit)
      get :index, {user_id:subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommits).should eq(@branch.kommits)
    end
  end

  describe "GET show" do
    login_user
    it "assigns the requested kommit as @kommit" do
      create_branch_for(@current_user)
      kommit =  FactoryGirl.create(:kommit)
      @branch.kommits << kommit
      get :show, {:id => kommit.to_param, user_id:subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommit).should eq(kommit)
    end
  end

  describe "GET new" do
    login_user
    it "assigns a new kommit as @kommit" do
      create_branch_for(@current_user)
      get :new, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommit).should be_a_new(Kommit)
    end
  end

  describe "POST create" do
    login_user
    describe "with valid params" do
      it "creates a new Kommit" do
        create_branch_for(@current_user)
        expect {
          post :create, {user_id: subject.current_user,repository_id:@repository, branch_id:@branch, kommit:valid_attributes}, valid_session
        }.to change(Kommit, :count).by(1)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved kommit as @kommit" do
        create_branch_for(@current_user)
        Kommit.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch, kommit:{message: '', revision:''}}, valid_session
        assigns(:kommit).should be_a_new(Kommit)
      end

      it "re-renders the 'new' template" do
        create_branch_for(@current_user)
        Kommit.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch, :kommit => {:message => ''}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "delete destroy" do
  end
end