require 'spec_helper'
describe Admin::TextRepositoriesController do
  login_user

  def valid_attributes
    {
      type: "TextRepository",
      user_id: 1,
      repository_type_id: 1,
      description: "Hello,world",
      name: "sample code"
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all text_repositories as @text_repositories" do
      user = FactoryGirl.create(:user_with_text_repositories)
      text_repositories = user.text_repositories
      get :index, {user_id: user.to_param}, valid_session
      assigns(:text_repositories).should eq(text_repositories)
    end
  end

  describe "GET show" do
    it "assigns the requested text_repository as @text_repository" do
      user = FactoryGirl.create(:user_with_text_repositories)
      text_repository = user.text_repositories.first
      get :show, {user_id: user.to_param,:id => text_repository.to_param}, valid_session
      assigns(:text_repository).should eq(text_repository)
    end
  end


  describe "GET edit" do
    context "When already login" do
      login_user
      it "assigns the requested text_repository as @text_repository" do
        text_repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        get :edit, {user_id: subject.current_user, :id => text_repository}, valid_session
        assigns(:text_repository).should eq(text_repository)
      end
    end
    context "When not authenticated" do
    end
  end


  describe "PUT update" do
    login_user
    describe "with valid params" do
      it "updates the requested text_repository" do
        text_repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        TextRepository.any_instance.should_receive(:update_attributes).with({'description' => 'test', 'name' => 'test'})
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => {'description' => 'test','name' => 'test'}}, valid_session
      end

      it "assigns the requested text_repository as @text_repository" do
        text_repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => {'description' => 'test' } }, valid_session
        assigns(:text_repository).should eq(text_repository)
      end

      it "redirects to the text_repository" do
        text_repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => valid_attributes}, valid_session
        response.should redirect_to user_text_repository_path(subject.current_user)
        flash[:notice].should eq I18n.t("flash.info.update.notice", model: I18n.t("activerecord.models.text_repository"))
      end
    end

    describe "with invalid params" do
      it "assigns the text_repository as @text_repository" do
        text_repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        TextRepository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => {}}, valid_session
        assigns(:text_repository).should eq(text_repository)
      end

      it "re-renders the 'edit' template" do
        text_repository = FactoryGirl.create(:text_repository, user: @current_user).becomes(TextRepository)
        TextRepository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end


end
