module Admin
  class KommitsController < ApplicationController
    before_filter :user_repository_authenticate
    def index
      @kommits = Branch.find(params[:branch_id]).kommits

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @kommits }
      end
    end

    def show
      @kommit = Kommit.find(params[:id])

      respond_to do |format|
        format.html
        format.json { render json: @kommit }
      end
    end

    def new
      #@kommit = Kommit.new
      @branch = Branch.find(params[:branch_id])
      @kommit = Kommit.new
      @branch_kommit = BranchKommit.new(branch_id:@branch, kommit_id:@kommit)
      @new_post = Post.new
      @new_post.branch = @branch

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @kommit }
      end
    end

    def create
      branch = Branch.find(params[:branch_id])
      @kommit = Kommit.new(params[:kommit])
      @kommit.branches << branch
      branch.posts.create(params[:post]) unless blank_post?

      respond_to do |format|
        if @kommit.save
          format.html { redirect_to user_admin_repository_branch_kommits_path(params[:user_id],params[:repository_id], params[:branch_id]), notice: 'Kommit was successfully created.' }
          format.json { render json: @kommit, status: :created, location: @kommit }
        else
          format.html { render action: "new" }
          format.json { render json: @kommit.errors, status: :unprocessable_entity }
        end
      end
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
    def blank_post?
      params[:post].all?{|key, value| value.blank?}
    end
  end
end
