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

  before(:each) do
    create_repository_for(subject.current_user)
  end

  after(:each) do
    @repository.destroy
  end

  describe "GET new" do
    login_user
    it "assigns a new branch as @branch" do
      get  :new, {branch_id: @repository.master}
      assigns(:branch).should be_a_new(Branch)
    end
    it "assigns a orig branch as @orig_branch" do
      get :new, {branch_id: @repository.master}
      assigns(:orig_branch).should eq @repository.master
    end
  end

  describe "POST create" do
    login_user
    describe "with valid params" do
      it "creates a new Branch" do
        expect {
          post :create, {branch_id:@repository.master, branch:valid_attributes}
        }.to change(Branch, :count).by(1)
      end

      it "invokes checkout" do
        branch = create(:branch, repository:@repository)
        Branch.any_instance.should_receive(:checkout).with({"name"=>"Branch1"}).and_return(branch)
        post :create, {branch_id:@repository.master,  branch:valid_attributes}
      end

      it "assigns a newly created branch as @branch" do
        post :create, {branch_id:@repository.master, branch:valid_attributes}
        assigns(:branch).should be_a(Branch)
        assigns(:branch).should be_persisted
      end

      it "redirects to the created branch" do
        post :create, {branch_id:@repository.master, branch:valid_attributes}
        response.should redirect_to repository_path(@repository)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved branch as @branch" do
        Branch.any_instance.stub(:save).and_return(false)
        post :create, {branch_id:@repository.master}
        assigns(:branch).should be_a_new(Branch)
      end

      it "re-renders the 'new' template" do
        Branch.any_instance.stub(:save).and_return(false)
        post :create, {branch_id:@repository.master}
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    context "try to destroy master" do
      it "destroys the requested branch" do
        Branch.any_instance.should_receive(:destroyable?).and_return(false)
        expect {
          delete :destroy, {:id => @repository.master}, valid_session
        }.to change(Branch, :count).by(0)
      end

      it "redirects to the branches list" do
        delete :destroy, {:id => @repository.master}, valid_session
        response.should redirect_to repository_path(@repository)
      end
    end
    context "try to destroy another" do
      before do
        @another = @repository.master.checkout(name:"another")
        @another.save
      end
      it "destroyes the requested branch" do
        Branch.any_instance.should_receive(:destroyable?).and_return(true)
        expect {
          delete :destroy, {:id => @another}, valid_session
        }.to change(Branch, :count).by(-1)
      end

    end
  end

end
