module Admin
  class BranchesController < ApplicationController
    layout "admin_menu"
    before_filter :user_branch_authenticate, only:[:show, :new, :destroy]
    #before_filter :user_repository_authenticate, only:[:new, :create]
    before_filter :status_has_no_changes?, only: [:new, :create]

    def show
      @branch = Branch.find(params[:id])
      @repository = @branch.repository
      @user = @repository.owner

      respond_to do |format|
        format.html
        format.json { render json: @kommits }
      end
    end

    def new
      @branch = Branch.find(params[:branch_id])
      @repository = @branch.repository
      @user = @repository.owner
      @new_branch = Branch.new

      respond_to do |format|
        format.html
        format.json { render json: @branch }
      end
    end

    def create
      @branch = Branch.find(params[:branch_id])
      @repository = @branch.repository
      @user = @repository.owner
      @new_branch = @branch.checkout(params[:branch])

      respond_to do |format|
        if @new_branch.save
          @new_branch.kommits << @branch.kommits
          format.html { redirect_to repository_path(@new_branch.repository), notice: t("flash.info.create.notice", model: t("activerecord.models.branch"))}
          format.json { render json: @new_branch, status: :created, location: @new_branch}
        else
          format.html { render action: "new" }
          format.json { render json: @new_branch.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @branch = Branch.find(params[:id])
      if @branch.destroyable?
        @branch.destroy

        respond_to do |format|
          format.html { redirect_to repository_path(@branch.repository), notice: t("flash.info.destroy.notice", model: t("activerecord.models.branch")) }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to repository_path(@branch.repository), alert: t("flash.alert.cannot_destroy_branch") }
          format.json { head :no_content }
        end
      end
    end
  end
end
