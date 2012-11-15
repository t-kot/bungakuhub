class UsersController < ApplicationController
  before_filter :valid_user_authenticate, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: I18n.t("flash.info.update.notice",model: I18n.t("activerecord.models.user")) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: I18n.t("flash.info.delete_user")}
      format.json { head :no_content }
    end
  end
end
