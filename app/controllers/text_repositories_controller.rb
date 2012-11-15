class TextRepositoriesController < ApplicationController
  before_filter :authenticate_user!, except:[:index, :show]
  def index
    @text_repositories = User.find(params[:user_id]).text_repositories

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

  def new
    @text_repository = TextRepository.new
    @text_repository.user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text_repository }
    end
  end

  def create
    @text_repository = TextRepository.new(params[:text_repository])

    respond_to do |format|
      if @text_repository.save
        format.html { redirect_to text_repository_path(@text_repository), notice: t("flash.info.create.notice", model: t("activerecord.models.text_repository")) }
        format.json { render json: @text_repository, status: :created, location: @text_repository }
      else
        format.html { render action: "new" }
        format.json { render json: @text_repository.errors, status: :unprocessable_entity }
      end
    end
  end

end
