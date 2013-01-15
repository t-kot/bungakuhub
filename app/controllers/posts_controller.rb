class PostsController < ApplicationController
  def index
    @branch = Branch.find(params[:branch_id])
    @posts = @branch.posts
  end

  def show
    @post = Post.find(params[:id])
  end
end
