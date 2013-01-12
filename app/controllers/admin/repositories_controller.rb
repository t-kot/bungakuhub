module Admin
  class RepositoriesController < ApplicationController
    layout "admin_menu", except: [:index]
    before_filter :load_items, only:[:show, :edit, :update, :destroy]
    before_filter :authenticate_user!
    before_filter :user_repository_authenticate, only: [:show, :edit, :update, :destroy]
    def index
      @repositories = current_user.repositories

      respond_to do |format|
        format.html
        format.json { render json: @repositories }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @repository }
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @repository.update_attributes(params[:repository])
          format.html { redirect_to repository_url(@repository), notice: t("flash.info.update.notice", model: t("activerecord.models.repository")) }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @repository.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @repository.destroy

      respond_to do |format|
        format.html { redirect_to user_repositories_url(current_user) }
        format.json { head :no_content }
      end
    end

    private
    def load_items
      @repository = Repository.find(params[:id])
      @branch = @repository.master
      @user = @repository.user
    end
  end
end
