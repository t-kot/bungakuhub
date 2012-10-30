require 'spec_helper'

describe Admin::BranchesController do

  def valid_attributes
    {
      name: "Branch1"
    }
  end

  def valid_session
    {}
  end

  describe "GET new" do
    context "already authenticated" do
      login_user
      it "assigns a new branch as @branch" do
        create_repository_for(@current_user)
        get :new, {user_id: subject.current_user, repository_id: @repository}, valid_session
        assigns(:branch).should be_a_new(Branch)
      end
    end
    context "not yet authenticated" do
      it "redirects to new session path" do
        user = FactoryGirl.create(:user)
        create_repository_for(user)
        get :new, {user_id: user, repository_id: @repository}, valid_session
        response.should redirect_to root_path
        flash[:alert].should eq I18n.t("flash.alert.access_denied")
      end
    end
  end

  describe "POST create" do
    login_user
    describe "with valid params" do
      it "creates a new Branch" do
        create_repository_for(@current_user)
        expect {
          post :create, {user_id: subject.current_user, repository_id: @repository, :branch => valid_attributes}, valid_session
        }.to change(Branch, :count).by(1)
      end

      it "assigns a newly created branch as @branch" do
        create_repository_for(@current_user)
        post :create, {user_id: subject.current_user, repository_id: @repository, :branch => valid_attributes}, valid_session
        assigns(:branch).should be_a(Branch)
        assigns(:branch).should be_persisted
      end

      it "redirects to the created branch" do
        create_repository_for(@current_user)
        post :create, {user_id: subject.current_user, repository_id: @repository, :branch => valid_attributes}, valid_session
        response.should redirect_to user_repository_path(@current_user, @repository)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved branch as @branch" do
        create_repository_for(@current_user)
        Branch.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id: @repository, :branch => {}}, valid_session
        assigns(:branch).should be_a_new(Branch)
      end

      it "re-renders the 'new' template" do
        create_repository_for(@current_user)
        Branch.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id: @repository, :branch => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    it "destroys the requested branch" do
      create_branch_for(@current_user)
      expect {
        delete :destroy, {user_id: subject.current_user, repository_id: @repository, :id => @branch.to_param}, valid_session
      }.to change(Branch, :count).by(-1)
    end

    it "redirects to the branches list" do
      create_branch_for(@current_user)
      delete :destroy, {user_id: subject.current_user, repository_id: @repository, :id => @branch.to_param}, valid_session
      response.should redirect_to user_repository_path(subject.current_user, @repository)
    end
  end

end
