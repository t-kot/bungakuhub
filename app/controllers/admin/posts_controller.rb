module Admin
  class PostsController < ApplicationController
    layout "admin_menu"

    def index
      @branch = Branch.find(params[:branch_id])
      @posts = @branch.posts
      @post = Post.new
      @repository = @branch.repository
      @user = @repository.user
    end

    def create
      @branch = Branch.find(params[:branch_id])
      @repository = @branch.repository
      @user = @repository.user
      @branch.enter do
        @post = Post.new(params[:post])
        @post.branch = @branch

        respond_to do |format|
          if @post.save
            format.html {redirect_to admin_branch_posts_path(params[:branch_id]), notice: t("flash.info.create.notice", model: t("activerecord.models.post"))}
          else
            @posts = @branch.posts
            format.html { render action: :index}
          end
        end
      end
    end

    def update
      @update_post = Post.find(params[:id])
      @branch = @update_post.branch
      @repository = @branch.repository
      @user = @repository.user
      @branch.enter do
        respond_to do |format|
          if @update_post.update_attributes(params[:post])
            format.html {redirect_to admin_branch_posts_path(@branch), notice: t("flash.info.update.notice", model: t("activerecord.models.post"))}
          else
            @post = Post.new
            @posts = @branch.posts
            format.html {render action: :index}
          end
        end
      end
    end

    def destroy
      @post = Post.find(params[:id])
      branch = @post.branch
      branch.enter do
        @post.destroy

        respond_to do |format|
          format.html { redirect_to admin_branch_posts_path(branch)}
          format.json { head :no_content}
        end
      end
    end
  end
end
