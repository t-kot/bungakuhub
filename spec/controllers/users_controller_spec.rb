#coding: utf-8
require 'spec_helper'

describe UsersController do
  login_user

  def valid_attributes
  end

  def valid_session
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = mock_model(User, id:1)
      User.should_receive(:find).with("1").and_return(user)
      get :show, {id: user}
      assigns(:user).should eq(user)
    end
  end

  describe "GET edit" do
    context "when edit by valid user" do 
      it "assigns the requested user as @user" do
        get :edit, {id:@current_user.to_param}, valid_session
        assigns(:user).should eq(@current_user)
      end
    end
    context "when edit by invalid user" do
      it "redirects to root" do
        user = mock_model(User, id:1)
        get :edit, {id:user}, valid_session
        response.should redirect_to(root_path)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        User.any_instance.should_receive(:update_attributes).with({'display_name' => 'hogehoge'})
        put :update, {id:@current_user.to_param, :user => {'display_name' => 'hogehoge'}}, valid_session
      end

      it "assigns the requested user as @user" do
        put :update, {:id => @current_user.to_param, :repository => valid_attributes}, valid_session
        assigns(:user).should eq(@current_user)
      end

      it "redirects to the user" do
        put :update, {:id => @current_user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to user_path(@current_user)
      end
      it "set a flash[:notice] message" do
        put :update, {:id => @current_user.to_param, :user => valid_attributes}, valid_session
        flash[:notice].should eq I18n.t("flash.info.update.notice",model: I18n.t("activerecord.models.user"))
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => @current_user.to_param, :user => {}}, valid_session
        assigns(:user).should eq(@current_user)
      end

      it "re-renders the 'edit' template" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => @current_user.to_param, :user => {'display_name'=> ''}}, valid_session
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroyes the requested user" do
      expect {
        delete :destroy, {id: @current_user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end
    context "when delete user successfully" do
      it "redirects to root" do
        delete :destroy, {id: @current_user.to_param}, valid_session
        response.should redirect_to(root_path)
      end
      it "set a flash[:notice] message" do
        delete :destroy, {id: @current_user.to_param}, valid_session
        flash[:notice].should eq I18n.t("flash.info.delete_user")

      end
    end
  end
end
