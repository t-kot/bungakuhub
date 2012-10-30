module Admin
  class TextRepositoriesController < ApplicationController
    before_filter :user_repository_authenticate, only: [:edit, :update]
    def index
      @text_repositories = TextRepository.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @text_repositories }
      end
    end

    def show
      @text_repository = TextRepository.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @text_repository }
      end
    end

    def edit
      @text_repository = TextRepository.find(params[:id])
    end

    def update
      @text_repository = TextRepository.find(params[:id])

      respond_to do |format|
        if @text_repository.update_attributes(params[:text_repository])
          format.html { redirect_to user_text_repository_path(current_user,@text_repository), notice: t("flash.info.update.notice", model:t("activerecord.models.text_repository"))}
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @text_repository.errors, status: :unprocessable_entity }
        end
      end
    end

  end
end
