#coding:utf-8
module Admin
  class MergesController < ApplicationController
    before_filter :status_has_no_changes?

    def new
      @branch = Branch.find(params[:branch_id])
      @targets = @branch.repository.branches - [@branch]
    end

    def create
      flash[:notice] = "マージされました"
      redirect_to :root
    end

  end
end
