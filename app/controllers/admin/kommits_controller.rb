require 'grit'
module Admin
  class KommitsController < ApplicationController
    before_filter :user_branch_authenticate
    before_filter :load_branch, only: [:index, :new, :create]
    def index
      @kommits = @branch.kommits

      respond_to do |format|
        format.html
        format.json { render json: @kommits }
      end
    end

    def show
      @kommit = Kommit.find(params[:id])
      repository = @kommit.repository

      respond_to do |format|
        format.html
        format.json { render json: @kommit }
      end
    end

    def new
      @kommit = Kommit.new
      @new_post = Post.new

      respond_to do |format|
        format.html
        format.json { render json: @kommit }
      end
    end

    def create
      @kommit = Kommit.new(params[:kommit])
      @kommit.user = current_user
      @kommit.branches << @branch
      create_new_post
      update_post

      respond_to do |format|
        if @kommit.save
          format.html { redirect_to admin_branch_kommits_path(params[:branch_id]), notice: 'Kommit was successfully created.' }
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

    def load_branch
      @branch = Branch.find(params[:branch_id])
    end

    def create_new_post
      branch = Branch.find(params[:branch_id])
      if blank_post?
        @new_post = Post.new
      else
        @new_post = branch.posts.build(params[:post])
        format.html { render action: "new"} unless @new_post.save
      end
    end

    def update_post
      if params[:update_posts].present?
        params[:update_posts].each do |key, value|
          value[:delete]? Post.find(key).destroy : Post.find(key).update_attributes(value)
        end
      end
    end

    def blank_post?
      params[:post].all?{|key, value| value.blank?} if params[:post].present?
    end
  end
end
