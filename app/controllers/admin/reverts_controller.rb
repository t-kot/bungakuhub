module Admin
  class RevertsController < ApplicationController
    before_filter :user_branch_authenticate

    def create
      @kommit = Kommit.find(params[:kommit_id])
      @kommit.revert
      branch = Branch.find(params[:branch_id])
      kommit = branch.kommits.build(message:@kommit.git_message,
                           revision:@kommit.git_revision)
      kommit.skip_callback = true
      kommit.save
      branch.delete_all_post
      @kommit.contents.each do |content|
        title = content.name.force_encoding("UTF-8").split(".").first
        branch.posts.create(skip_callback: true,
                            title: title,
                            body: content.data.force_encoding("UTF-8"))
      end
      
      redirect_to admin_branch_kommits_path(params[:branch_id])
    end
  
  end
end
