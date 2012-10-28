#class BranchesController < ApplicationController
#  def index
#    @branches = Branch.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @branches }
#    end
#  end
#
#  def show
#    @branch = Branch.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @branch }
#    end
#  end
#  def new
#  end
#
#  def create
#    @branch = Branch.new(params[:branch])
#
#    respond_to do |format|
#      if @branch.save
#        format.html { redirect_to user_repository_path(current_user,@branch.repository), notice: t("flash.info.create.notice", model: t("activerecord.models.branch"))}
#        format.json { render json: @branch, status: :created, location: @branch}
#      else
#        format.html { render action: "new" }
#        format.json { render json: @branch.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
#  def destroy
#    @branch = Branch.find(params[:id])
#    @branch.destroy
#
#    respond_to do |format|
#      format.html { redirect_to branches_url }
#      format.json { head :no_content }
#    end
#  end
#
#end
