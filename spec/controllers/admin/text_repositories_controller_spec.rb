require 'spec_helper'
describe Admin::TextRepositoriesController do
  login_user

  def valid_attributes
    {
      type: "TextRepository",
      user_id: 1,
      repository_type_id: 1,
      description: "Hello,world",
      name: "samplecode",
      category_id: 1
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    login_user
    let(:text_repositories){ [mock_model(TextRepository)] }
    before do
      subject.current_user.stub(:text_repositories).and_return text_repositories
    end
    it "assigns all text_repositories as @text_repositories" do
      get :index, {}, valid_session
      assigns(:text_repositories).should eq(text_repositories)
    end
  end

  describe "GET show" do
    login_user
    let(:text_repository){ mock_model(TextRepository, id:1, owner: subject.current_user) }
    before do
      TextRepository.stub(:find).with("1").and_return text_repository
      Repository.stub(:find).with("1").and_return text_repository
    end
    it "assigns the requested text_repository as @text_repository" do
      get :show, {user_id: subject.current_user,:id => text_repository}, valid_session
      assigns(:text_repository).should eq(text_repository)
    end
  end


  describe "GET edit" do
    context "When already login" do
      login_user
      let(:text_repository){ mock_model(TextRepository, id:1, owner:subject.current_user)}
      before do
        TextRepository.stub(:find).with("1").and_return text_repository
        Repository.stub(:find).with("1").and_return text_repository
      end

      it "assigns the requested text_repository as @text_repository" do
        get :edit, {user_id: subject.current_user, :id => text_repository}, valid_session
        assigns(:text_repository).should eq(text_repository)
      end
    end
    context "When not authenticated" do
    end
  end


  describe "PUT update" do
    login_user
    let(:text_repository){ mock_model(TextRepository, id:1, owner:subject.current_user).as_null_object}

    before do
      TextRepository.stub(:find).with("1").and_return text_repository
      Repository.stub(:find).with("1").and_return text_repository
    end
    describe "with valid params" do
      it "updates the requested text_repository" do
        text_repository.should_receive(:update_attributes).with({'description' => 'test', 'name' => 'test'})
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => {'description' => 'test','name' => 'test'}}, valid_session
      end

      it "assigns the requested text_repository as @text_repository" do
        put :update, {user_id: subject.current_user, :id => text_repository, :text_repository => {'description' => 'test' } }, valid_session
        assigns(:text_repository).should eq(text_repository)
      end

      it "redirects to the text_repository" do
        put :update, {user_id: subject.current_user, :id => text_repository, :text_repository => valid_attributes}, valid_session
        response.should redirect_to text_repository_path(text_repository)
      end

      it "display flash notice" do
        put :update, {user_id: subject.current_user, :id => text_repository, :text_repository => valid_attributes}, valid_session
        flash[:notice].should eq I18n.t("flash.info.update.notice", model: I18n.t("activerecord.models.text_repository"))
      end
    end

    describe "with invalid params" do
      before do
        text_repository.stub(:update_attributes).and_return false
      end
      it "assigns the text_repository as @text_repository" do
        put :update, {user_id: subject.current_user, :id => text_repository, :text_repository => {}}, valid_session
        assigns(:text_repository).should eq(text_repository)
      end

      it "re-renders the 'edit' template" do
        put :update, {user_id: subject.current_user, :id => text_repository, :text_repository => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end


end
