require 'spec_helper'
describe Users::RepositoriesController do

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
      user = FactoryGirl.create(:user_with_text_repositories)
      repositories = user.repositories

      get :index, {user_id: user.to_param}, valid_session
      assigns(:repositories).should eq(repositories)
    end
  end

  describe "GET show" do
    it "assigns the requested repository as @repository" do
      user = FactoryGirl.create(:user_with_text_repositories)
      repository = user.repositories.last
      get :show, {user_id: repository.to_param, id: repository.to_param}, valid_session
      assigns(:repository).should eq(repository)
    end
  end

  describe "GET edit" do
    context "when valid user" do
      login_user
      it "assigns the requested repository as @repository" do
        repository = FactoryGirl.create(:repository, user: @current_user).becomes(TextRepository)
        get :edit, {user_id:repository.user, id:repository.to_param}, valid_session
        assigns(:repository).should eq(repository)
      end
    end
    context "When invalid user" do
      it "redirects to root" do
        repository = FactoryGirl.create(:repository).becomes(TextRepository)
        get :edit, {user_id:repository.user,id:repository.to_param}, valid_session
        response.should redirect_to root_path
        flash[:alert].should eq I18n.t("flash.alert.access_denied")
      end
    end
  end


  describe "PUT update" do
    login_user
    describe "with valid params" do
      it "updates the requested repository" do
        repository = FactoryGirl.create(:text_repository, user: @current_user)
        TextRepository.any_instance.should_receive(:update_attributes).with({'name' => 'hogehoge'})
        put :update, {user_id: subject.current_user,:id => repository.to_param, :repository => {'name' => 'hogehoge'}}, valid_session
      end

      it "assigns the requested repository as @repository" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        put :update, {user_id: subject.current_user, :id => repository.to_param, :repository => valid_attributes}, valid_session
        assigns(:repository).should eq(repository)
      end

      it "redirects to the repository" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        put :update, {user_id: subject.current_user, :id => repository.to_param, :repository => valid_attributes}, valid_session
        response.should redirect_to user_repository_path(subject.current_user.to_param,repository)
      end
    end

    describe "with invalid params" do
      it "assigns the repository as @repository" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        Repository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: repository.user, :id => repository.to_param, :repository => {:name => ''}}, valid_session
        assigns(:repository).should eq(repository)
      end

      it "re-renders the 'edit' template" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        Repository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: repository.user, :id => repository.to_param, :repository => {:name => ''}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    context "When valid user" do
      login_user
      it "destroys the requested repository" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        expect {
          delete :destroy, {user_id: repository.user,:id => repository.to_param}, valid_session
        }.to change(Repository, :count).by(-1)
      end

      it "redirects to the repositories list" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        user = repository.user
        delete :destroy, {user_id: repository.user, :id => repository.to_param}, valid_session
        response.should redirect_to(user_repositories_url(user))
      end
    end
    context "When invalid user" do
      it "redirects to root" do
        repository = FactoryGirl.create(:text_repository).becomes(TextRepository)
        delete :destroy, {user_id:repository.user, :id => repository.to_param}, valid_session
        response.should redirect_to root_path
        flash[:alert].should eq I18n.t("flash.alert.access_denied")
      end
    end
  end

end
