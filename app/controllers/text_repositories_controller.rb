class TextRepositoriesController < ApplicationController
  before_filter :authenticate_user!, except:[:index]
  def index
    @text_repositories = TextRepository.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @text_repositories }
    end
  end

  def new
    @text_repository = TextRepository.new
    @text_repository.owner = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text_repository }
    end
  end

  def create
    @text_repository = TextRepository.new(params[:text_repository])

    respond_to do |format|
      if @text_repository.save
        format.html { redirect_to user_text_repository_path(current_user,@text_repository), notice: t("flash.info.create.notice", model: t("activerecord.models.text_repository")) }
        format.json { render json: @text_repository, status: :created, location: @text_repository }
      else
        format.html { render action: "new" }
        format.json { render json: @text_repository.errors, status: :unprocessable_entity }
      end
    end
  end

end
