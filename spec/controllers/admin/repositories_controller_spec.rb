require 'spec_helper'
describe Admin::RepositoriesController do
  login_user

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
      repositories = [FactoryGirl.create(:repository, user: subject.current_user).becomes(TextRepository)]

      get :index, {user_id: subject.current_user}, valid_session
      assigns(:repositories).should eq(repositories)
      repositories.each{|repository| repository.destroy}
    end
  end

  describe "GET show" do
    login_user
    it "assigns the requested repository as @repository" do
      repository = FactoryGirl.create(:repository, user: subject.current_user).becomes(TextRepository)
      get :show, {user_id: subject.current_user, id: repository.to_param}, valid_session
      assigns(:repository).should eq(repository)
      repository.destroy
    end
  end

  describe "GET edit" do
    context "when valid user" do
      login_user
      it "assigns the requested repository as @repository" do
        repository = FactoryGirl.create(:repository, user: @current_user).becomes(TextRepository)
        get :edit, {user_id:repository.user, id:repository.to_param}, valid_session
        assigns(:repository).should eq(repository)
        repository.destroy
      end
    end
    context "When invalid user" do
      it "redirects to root" do
        repository = FactoryGirl.create(:repository).becomes(TextRepository)
        get :edit, {user_id:repository.user,id:repository.to_param}, valid_session
        response.should redirect_to root_path
        flash[:alert].should eq I18n.t("flash.alert.access_denied")
        repository.destroy
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
        repository.destroy
      end

      it "assigns the requested repository as @repository" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        put :update, {user_id: subject.current_user, :id => repository.to_param, :repository => valid_attributes}, valid_session
        assigns(:repository).should eq(repository)
        repository.destroy
      end

      it "redirects to the repository" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        put :update, {user_id: subject.current_user, :id => repository.to_param, :repository => valid_attributes}, valid_session
        response.should redirect_to repository_path(repository)
        repository.destroy
      end
    end

    describe "with invalid params" do
      it "assigns the repository as @repository" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        Repository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: repository.user, :id => repository.to_param, :repository => {:name => ''}}, valid_session
        assigns(:repository).should eq(repository)
        repository.destroy
      end

      it "re-renders the 'edit' template" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        Repository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: repository.user, :id => repository.to_param, :repository => {:name => ''}}, valid_session
        response.should render_template("edit")
        repository.destroy
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
        repository.destroy
      end

      it "redirects to the repositories list" do
        repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        user = repository.user
        delete :destroy, {user_id: repository.user, :id => repository.to_param}, valid_session
        response.should redirect_to(user_repositories_url(user))
        repository.destroy
      end
    end
    context "When invalid user" do
      it "redirects to root" do
        repository = FactoryGirl.create(:text_repository).becomes(TextRepository)
        delete :destroy, {user_id:repository.user, :id => repository.to_param}, valid_session
        response.should redirect_to root_path
        flash[:alert].should eq I18n.t("flash.alert.access_denied")
        repository.destroy
      end
    end
  end

end
