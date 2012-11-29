require 'spec_helper'
describe Admin::KommitsController do

  def valid_attributes
    {
      bare:true,
      message:"First commit",
      revision:"Test"
    }
  end
  def valid_session;{};end

  before(:each) do
    create_branch_for(subject.current_user)
  end


  after(:each) do
    @repository.destroy
  end


  describe "GET index" do
    login_user
    it "assigns all kommits as @kommits" do
      @branch.kommits.create valid_attributes
      get :index, {user_id:subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommits).should eq(@branch.kommits)
    end
  end

  describe "GET show" do
    login_user
    it "assigns the requested kommit as @kommit" do
      kommit = @branch.kommits.create valid_attributes
      get :show, {:id => kommit.to_param, user_id:subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommit).should eq(kommit)
    end
  end

  describe "GET new" do
    login_user
    it "assigns a new kommit as @kommit" do
      get :new, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommit).should be_a_new(Kommit)
    end
  end

  describe "POST create" do
    login_user
    describe "with valid params" do
      it "creates a new Kommit" do
        create(:post, branch:@branch)
        expect {
          post :create, {user_id: subject.current_user,repository_id:@repository, branch_id:@branch, kommit:valid_attributes}, valid_session
        }.to change(Kommit, :count).by(1)
      end

      it "redirects to the branch" do
        create(:post, branch:@branch)
        post :create, {user_id: subject.current_user, branch_id: @branch, kommit: valid_attributes}, valid_session
        response.should redirect_to admin_branch_kommits_path(@branch)
      end


    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved kommit as @kommit" do
        create(:post, branch:@branch)
        Kommit.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch, kommit:{message: '', revision:''}}, valid_session
        assigns(:kommit).should be_a_new(Kommit)
      end

      it "re-renders the 'new' template" do
        create(:post, branch:@branch)
        Kommit.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch, :kommit => {:message => ''}}, valid_session
        response.should render_template("new")
      end
    end

    describe "when nothing to do" do
      it "redirects to back" do
        request.env["HTTP_REFERER"] = root_path
        post :create, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch, kommit:{message:"hogehoge"}}
        response.should redirect_to root_path
      end
    end
  end

  describe "delete destroy" do
  end
end
