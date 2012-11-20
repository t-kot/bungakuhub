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
      @branch = Branch.find(params[:branch_id])

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
      build_new_post unless blank_post?
      update_post if params[:update_posts].present?
      @kommit = @branch.kommits.build(params[:kommit])
      @kommit.user = current_user
      @kommit.branches << @branch

      respond_to do |format|
        if save_checker(@new_post) && @kommit.save
          format.html { redirect_to admin_branch_kommits_path(params[:branch_id]), notice: t("flash.info.create.notice", model: t("activerecord.models.kommit")) }
          format.json { render json: @kommit, status: :created, location: @kommit }
        else
          @new_post.errors.each{|key, value| @kommit.errors.add key, value} if @new_post
          reset_new_post if blank_post?
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

    def build_new_post
      @new_post = @branch.posts.build(params[:post])
    end

    def reset_new_post
      @new_post = Post.new
    end


    def update_post
      params[:update_posts].each do |key, value|
        if value[:delete]
          Post.find(key).destroy
        else
          Post.find(key).update_attributes(value)
        end
      end
    end

    def blank_post?
      params[:post].all?{|key, value| value.blank?} if params[:post].present?
    end

    def save_checker(new_post)
      return new_post.save if !blank_post?
      true
    end
  end
end
