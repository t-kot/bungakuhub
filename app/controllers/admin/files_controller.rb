#coding: utf-8
module Admin
  class FilesController < ApplicationController
    layout "admin_menu"
    before_filter :load_items, only: [:index, :show]

    def index
      @kommit = Kommit.find(params[:kommit_id])
    end

    def show
      @kommit = Kommit.find(params[:kommit_id])
      @file = @kommit.inspect(params[:name])
    end

    def update
      @branch = Branch.find(params[:branch_id])
      @kommit = Kommit.find(params[:kommit_id])
      restore_data = @kommit.inspect(params[:name])
      post = @branch.posts.find_by_title(params[:name])

      @branch.enter do
        ### 過去にバリデーションに通っているのだから
        ### 必ず保存できないとならない
        ### そのため保存に失敗したら例外を投げる
        if post
          post.update_attributes!(body: restore_data)
        else
          Post.create!(title:params[:name], body: restore_data)
        end

        respond_to do |format|
          format.html {redirect_to admin_branch_posts_path(@branch), notice: t("flash.info.update.notice", model: t("activerecord.models.post"))}
        end
      end
    end

    def load_items
      @branch = Branch.find(params[:branch_id])
      @repository = @branch.repository
      @user = @repository.user
    end

  end
end
