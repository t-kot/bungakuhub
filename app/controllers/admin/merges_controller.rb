#coding:utf-8
module Admin
  class MergesController < ApplicationController
    before_filter :status_has_no_changes?

    def new
      @branch = Branch.find(params[:branch_id])
      @targets = @branch.repository.branches - [@branch]
    end

    def create
      @merging_branch = Branch.find(params[:branch_id])
      @merged_branch = Branch.find(params[:merge][:target])

      respond_to do |format|
        if @merging_branch.merge(@merged_branch)
          flash[:notice] = "マージされました"
          format.html {redirect_to branch_path(@merging_branch), notice: "マージされました"}
          format.json {render json: @merging_branch, status: :created, location: @merging_branch }
        else
          format.html {render action: "new"}
        end
      end
    end
  end
end
