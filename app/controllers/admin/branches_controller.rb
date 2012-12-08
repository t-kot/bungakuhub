module Admin
  class BranchesController < ApplicationController
    before_filter :user_branch_authenticate, only:[:show, :new, :destroy]
    #before_filter :user_repository_authenticate, only:[:new, :create]
    before_filter :status_has_no_changes?, only: [:new, :create]

    def show
      @branch = Branch.find(params[:id])

      respond_to do |format|
        format.html
        format.json { render json: @kommits }
      end
    end

    def new
      @orig_branch = Branch.find(params[:branch_id])
      @branch = Branch.new

      respond_to do |format|
        format.html
        format.json { render json: @branch }
      end
    end

    def create
      @orig_branch = Branch.find(params[:branch_id])
      @branch = @orig_branch.checkout(params[:branch])

      respond_to do |format|
        if @branch.save
          @branch.kommits << @orig_branch.kommits
          format.html { redirect_to repository_path(@branch.repository), notice: t("flash.info.create.notice", model: t("activerecord.models.branch"))}
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
        format.html { redirect_to repository_path(@branch.repository), notice: t("flash.info.destroy.notice", model: t("activerecord.models.branch")) }
        format.json { head :no_content }
      end
    end
  end
end
