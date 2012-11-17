module Admin
  class RepositoriesController < ApplicationController
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
      @repository = Repository.find(params[:id])

      respond_to do |format|
        format.html
        format.json { render json: @repository }
      end
    end

    def edit
      @repository = Repository.find(params[:id])
    end

    def update
      @repository = Repository.find(params[:id])

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
      @repository = Repository.find(params[:id])
      @repository.destroy

      respond_to do |format|
        format.html { redirect_to user_repositories_url(current_user) }
        format.json { head :no_content }
      end
    end
  end
end
