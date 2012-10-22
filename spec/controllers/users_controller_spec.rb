require 'spec_helper'

describe UsersController do

  def valid_attributes
  end

  def valid_session
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = FactoryGirl.create(:tanaka)
      get :show, {id: user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      user = FactoryGirl.create(:tanaka)
      get :edit, {id:user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = FactoryGirl.create(:tanaka)
        User.any_instance.should_receive(:update_attributes).with({'display_name' => 'hogehoge'})
        put :update, {id:user.to_param, :user => {'display_name' => 'hogehoge'}}, valid_session
      end

      it "assigns the requested user as @user" do
        user = FactoryGirl.create(:tanaka)
        put :update, {:id => user.to_param, :repository => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the user" do
        user = FactoryGirl.create(:tanaka)
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to user_path(user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = FactoryGirl.create(:tanaka)
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => {}}, valid_session
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        user = FactoryGirl.create(:tanaka)
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => {'display_name'=> ''}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
  end
end
