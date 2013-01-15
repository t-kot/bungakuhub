class BranchesController < ApplicationController
  layout "repository_menu", only: [:show]
  before_filter :load_items, only:[:show]
  def index
    @branches = Repository.find(params[:repository_id]).branches

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @branches }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @branch }
    end
  end
  def load_items
    @branch = Branch.find(params[:id])
    @repository = @branch.repository
    @user = @repository.user
  end
end
