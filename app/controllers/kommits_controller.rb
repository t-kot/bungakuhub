class KommitsController < ApplicationController
  def index
    @kommits = Branch.find(params[:branch_id]).kommits

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kommits }
    end
  end

  def show
    @kommit = Kommit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kommit }
    end
  end
end
