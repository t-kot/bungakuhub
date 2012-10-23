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
      #user = FactoryGirl.create(:tanaka)
      user = @user
      get :show, {id: user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      
      get :edit, {id:@user.to_param}, valid_session
      assigns(:user).should eq(@user)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        User.any_instance.should_receive(:update_attributes).with({'display_name' => 'hogehoge'})
        put :update, {id:@user.to_param, :user => {'display_name' => 'hogehoge'}}, valid_session
      end

      it "assigns the requested user as @user" do
        put :update, {:id => @user.to_param, :repository => valid_attributes}, valid_session
        assigns(:user).should eq(@user)
      end

      it "redirects to the user" do
        put :update, {:id => @user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to user_path(@user)
      end
      it "set a flash[:notice] message" do
        put :update, {:id => @user.to_param, :user => valid_attributes}, valid_session
        flash[:notice].should eq I18n.t("flash.info.update.notice",model: I18n.t("activerecord.models.user"))
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => @user.to_param, :user => {}}, valid_session
        assigns(:user).should eq(@user)
      end

      it "re-renders the 'edit' template" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => @user.to_param, :user => {'display_name'=> ''}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroyes the requested user" do
      expect {
        delete :destroy, {id: @user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end
    context "when delete user successfully" do
      it "redirects to root" do
        delete :destroy, {id: @user.to_param}, valid_session
        response.should redirect_to(root_path)
      end
      it "set a flash[:notice] message" do
        delete :destroy, {id: @user.to_param}, valid_session
        flash[:notice].should eq I18n.t("flash.info.delete_user")

      end
    end
  end
end
