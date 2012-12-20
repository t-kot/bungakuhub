module Admin
  class RollbacksController < ApplicationController
    before_filter :status_has_no_changes?

    def create
      branch = Branch.find(params[:branch_id])
      kommit = Kommit.find(params[:kommit_id])
      branch.enter do 
        branch.rollback_to(kommit)

        respond_to do |format|
          format.html { redirect_to admin_branch_posts_path(params[:branch_id]), notice: t("flash.info.rollback.success")}
        end
      end
    end

  end
end
