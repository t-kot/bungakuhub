class BranchesController < ApplicationController
  def index
    @branches = Repository.find(params[:repository_id]).branches

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @branches }
    end
  end

  def show
    @branch = Branch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @branch }
    end
  end

end
