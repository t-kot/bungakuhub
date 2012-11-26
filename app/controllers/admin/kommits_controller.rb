require 'grit'
module Admin
  class KommitsController < ApplicationController
    before_filter :user_branch_authenticate
    before_filter :load_branch, only: [:index, :new, :create]
    #before_filter :checkout_target, only: [:new]
    #after_filter :checkout_master, only: [:new]
    def index
      @kommits = @branch.kommits

      respond_to do |format|
        format.html
        format.json { render json: @kommits }
      end
    end

    def show
      @kommit = Kommit.find(params[:id])
      @branch = Branch.find(params[:branch_id])

      respond_to do |format|
        format.html
        format.json { render json: @kommit }
      end
    end

    def new
      @branch.repository.checkout_to(@branch.name)
      @kommit = Kommit.new
      @post = Post.new
      @status = @branch.status

      respond_to do |format|
        format.html
        format.json { render json: @kommit }
      end
      @branch.repository.checkout_to("master")
    end

    def create
      @branch.repository.checkout_to(@branch.name)
      @kommit = Kommit.new(params[:kommit])
      @kommit.user = current_user
      @kommit.branches << @branch
      @status = @branch.status

      respond_to do |format|
        if @kommit.save
          format.html { redirect_to admin_branch_kommits_path(params[:branch_id]), notice: t("flash.info.create.notice", model: t("activerecord.models.kommit")) }
          format.json { render json: @kommit, status: :created, location: @kommit }
        else
          format.html { render action: "new" }
          format.json { render json: @kommit.errors, status: :unprocessable_entity }
        end
      end
      @branch.repository.checkout_to("master")
    end

    def destroy
      @kommit = Kommit.find(params[:id])
      @kommit.destroy

      respond_to do |format|
        format.html { redirect_to user_admin_repository_branch_kommits_url(params[:user_id], params[:repository_id], params[:branch_id])}
        format.json { head :no_content }
      end
    end


    private

    def load_branch
      @branch = Branch.find(params[:branch_id])
    end


  end
end
