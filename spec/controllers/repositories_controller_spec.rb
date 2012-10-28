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
    it "assigns all repositories as @repositories" do
      repositories = Repository.all

      get :index, valid_session
      assigns(:repositories).should eq(repositories)

    end
  end


  describe "GET new" do
    context "already authenticated" do
      login_user
      it "assigns a new repository as @repository" do
        get :new, {user_id: subject.current_user}, valid_session
        assigns(:repository).should be_a_new(Repository)
      end
    end
    context "not yet authenticated" do
      it "redirects to new session path" do
        get :new, {user_id: subject.current_user}, valid_session
        response.should redirect_to new_user_session_path
        flash[:alert].should eq I18n.t("devise.failure.unauthenticated")
      end
    end
  end
end
