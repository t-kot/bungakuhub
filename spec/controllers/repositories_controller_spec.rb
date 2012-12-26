require 'spec_helper'
describe RepositoriesController do


  def valid_attributes
    {
      type: "TextRepository",
      repository_type_id: 1,
      description: "HOGEHOGE",
      name: "fuga"
    }
  end

  def valid_session
  end

  describe "GET index" do
    let(:user){ mock_model(User, id:1)}
    let(:repositories){ [double(Repository)] }
    before do
      user.stub(:repositories).and_return(repositories)
      User.should_receive(:find).with("1").and_return(user)
    end

    it "assigns all repositories as @repositories" do
      get :index, {user_id: user}, valid_session
      assigns(:repositories).should eq(repositories)
    end
  end

  describe "GET show" do
    let(:repository){ mock_model(Repository, id:1)}
    before do
      Repository.should_receive(:find).with("1").and_return(repository)
    end
    it "assigns requested repository as @repository" do
      get :show, {id:repository}
      assigns(:repository).should eq repository
    end
  end


  describe "GET new" do
    context "already authenticated" do
      login_user
      it "assigns a new repository as @repository" do
        get :new, {user_id: subject.current_user}
        assigns(:repository).should be_a_new(Repository)
      end
    end
    context "not yet authenticated" do
      it "redirects to new session path" do
        get :new, {user_id: subject.current_user}
        response.should redirect_to new_user_session_path
        flash[:alert].should eq I18n.t("devise.failure.unauthenticated")
      end
    end
  end
end
