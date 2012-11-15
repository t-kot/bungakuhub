class RepositoriesController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def index
    @repositories = User.find(params[:user_id]).repositories

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

  def new
    @repository = Repository.new

    respond_to do |format|
      format.html
      format.json { render json: @repository }
    end
  end

end
