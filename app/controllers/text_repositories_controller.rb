class TextRepositoriesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :valid_user_authenticate, only: [:new, :create]
  def index
    @text_repositories = User.find(params[:user_id]).text_repositories

    respond_to do |format|
      format.html
      format.json { render json: @text_repositories }
    end
  end

  def show
    @text_repository = TextRepository.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @text_repository }
    end
  end

  def new
    @text_repository = TextRepository.new

    respond_to do |format|
      format.html
      format.json { render json: @text_repository }
    end
  end

  def create
    @text_repository = current_user.text_repositories.build(params[:text_repository])

    respond_to do |format|
      if @text_repository.save
        format.html { redirect_to admin_branch_path(@text_repository.master), notice: t("flash.info.create.notice", model: t("activerecord.models.text_repository")) }
        format.json { render json: @text_repository, status: :created, location: @text_repository }
      else
        format.html { render action: "new" }
        format.json { render json: @text_repository.errors, status: :unprocessable_entity }
      end
    end
  end

end
