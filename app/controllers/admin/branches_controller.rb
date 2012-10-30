module Admin
  class BranchesController < ApplicationController
    before_filter :user_repository_authenticate

    def show
      @branch = Branch.find(params[:id])

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @kommits }
      end
    end

    def new
      @branch = Branch.new
      @branch.repository = Repository.find(params[:repository_id])
    end

    def create
      @branch = Branch.new(params[:branch])
      @branch.repository = Repository.find(params[:repository_id])

      respond_to do |format|
        if @branch.save
          format.html { redirect_to user_repository_path(current_user,@branch.repository), notice: t("flash.info.create.notice", model: t("activerecord.models.branch"))}
          format.json { render json: @branch, status: :created, location: @branch}
        else
          format.html { render action: "new" }
          format.json { render json: @branch.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @branch = Branch.find(params[:id])
      @branch.destroy

      respond_to do |format|
        format.html { redirect_to user_repository_path(current_user, @branch.repository), notice: t("flash.info.destroy.notice", model: t("activerecord.models.branch")) }
        format.json { head :no_content }
      end
    end
  end
end
