module Admin
  class MergesController < ApplicationController

    def new
      @branch = Branch.find(params[:branch_id])
      @targets = @branch.repository.branches - [@branch]
    end

    def create
      flash[:notice] = "Merged!"
      redirect_to :root
    end

  end
end
