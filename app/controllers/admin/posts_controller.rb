module Admin
  class PostsController < ApplicationController

    def index
      @branch = Branch.find(params[:branch_id])
      @posts = @branch.posts
      @post = Post.new
    end

    def create
      @branch = Branch.find(params[:branch_id])
      @branch.repository.lock do
        @branch.repository.checkout_to(@branch.name)
        @post = Post.new(params[:post])
        @post.branch = @branch

        respond_to do |format|
          if @post.valid?
            @post.save
            format.html {redirect_to admin_branch_posts_path(params[:branch_id]), notice: t("flash.info.create.notice", model: t("activerecord.models.post"))}
          else
            @posts = @branch.posts
            format.html { render action: :index}
          end
        end
        @branch.repository.checkout_to("master")
      end
    end

    def update
      @update_post = Post.find(params[:id])
      @branch = @update_post.branch
      @branch.repository.lock do
        @branch.repository.checkout_to(@branch.name)
        respond_to do |format|
          if @update_post.update_attributes(params[:post])
            format.html {redirect_to admin_branch_posts_path(@branch), notice: t("flash.info.update.notice", model: t("activerecord.models.post"))}
          else
            @post = Post.new
            @posts = @branch.posts
            format.html {render action: :index}
          end
        end
        @branch.repository.checkout_to("master")
      end
    end

    def destroy
      @post = Post.find(params[:id])
      branch = @post.branch
      branch.repository.checkout_to(branch.name)
      @post.destroy

      respond_to do |format|
        format.html { redirect_to admin_branch_posts_path(branch)}
        format.json { head :no_content}
      end
      branch.repository.checkout_to("master")
    end
  end
end
