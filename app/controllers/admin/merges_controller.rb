#coding:utf-8
module Admin
  class MergesController < ApplicationController

    def new
      @branch = Branch.find(params[:branch_id])
      #@targets = @branch.repository.branches - [@branch]
      @targets = @branch.brothers
    end

    def create
      @merging_branch = Branch.find(params[:branch_id])
      @merged_branch = Branch.find(params[:merge][:target])
      if @merging_branch.nothing_to_commit? && @merged_branch.nothing_to_commit?
        @merging_branch.enter do
          @merging_branch.merge(@merged_branch)
          respond_to do |format|
            flash[:notice] = "マージされました"
            format.html {redirect_to branch_path(@merging_branch), notice: "マージされました"}
            format.json {render json: @merging_branch, status: :created, location: @merging_branch }
          end
        end
      else
        flash[:alert] = t("flash.alert.kommit_to_continue")
        redirect_to new_admin_branch_merge_path(@merging_branch)
      end
    end
  end
end
