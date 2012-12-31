class FollowingsController < ApplicationController
  before_filter :authenticate_user!, only:[:create]

  def index
    @user = User.find(params[:user_id])
    @followings = @user.followings
  end

  def create
    user = User.find(params[:user_id])
    current_user.follow!(user)
    respond_to do |format|
      format.html {redirect_to user_path(user), notice: t("flash.info.create.following", user_name: user.display_name)}
      format.json { render json: no_content }
    end
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow!(user)
    respond_to do |format|
      format.html {redirect_to user_path(user), notice: t("flash.info.destroy.following", user_name: user.display_name)}
      format.json {render json: no_content }
    end
  end

end
