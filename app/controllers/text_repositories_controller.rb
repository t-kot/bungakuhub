class TextRepositoriesController < ApplicationController
  # GET /text_repositories
  # GET /text_repositories.json
  def index
    @text_repositories = TextRepository.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @text_repositories }
    end
  end

  # GET /text_repositories/1
  # GET /text_repositories/1.json
  def show
    @text_repository = TextRepository.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text_repository }
    end
  end

  # GET /text_repositories/new
  # GET /text_repositories/new.json
  def new
    @text_repository = TextRepository.new
    @text_repository.user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text_repository }
    end
  end

  # GET /text_repositories/1/edit
  def edit
    @text_repository = TextRepository.find(params[:id])
  end

  # POST /text_repositories
  # POST /text_repositories.json
  def create
    @text_repository = TextRepository.new(params[:text_repository])

    respond_to do |format|
      if @text_repository.save
        format.html { redirect_to user_text_repository_path(current_user,@text_repository), notice: 'Text repository was successfully created.' }
        format.json { render json: @text_repository, status: :created, location: @text_repository }
      else
        format.html { render action: "new" }
        format.json { render json: @text_repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /text_repositories/1
  # PUT /text_repositories/1.json
  def update
    @text_repository = TextRepository.find(params[:id])

    respond_to do |format|
      if @text_repository.update_attributes(params[:text_repository])
        format.html { redirect_to user_text_repository_path(current_user,@text_repository), notice: 'Text repository was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text_repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_repositories/1
  # DELETE /text_repositories/1.json
  def destroy
    @text_repository = TextRepository.find(params[:id])
    @text_repository.destroy

    respond_to do |format|
      format.html { redirect_to user_text_repositories_url(current_user) }
      format.json { head :no_content }
    end
  end
end
