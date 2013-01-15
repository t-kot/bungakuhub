class KommitsController < ApplicationController
  layout "repository_menu"
  before_filter :load_items
  def index
    @kommits = @branch.kommits

    respond_to do |format|
      format.html
      format.json { render json: @kommits }
    end
  end

  def show
    @kommit = Kommit.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kommit }
    end
  end

  def load_items
    @branch = Branch.find(params[:branch_id])
    @repository = @branch.repository
    @user = @repository.user
  end
end
