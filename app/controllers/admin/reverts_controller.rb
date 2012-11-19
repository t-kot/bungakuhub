module Admin
  class RevertsController < ApplicationController
    before_filter :user_branch_authenticate

    def create
      @kommit = Kommit.find(params[:kommit_id])
      branch = Branch.find(params[:branch_id])
      @kommit.revert(branch.name)
      kommit = branch.kommits.create(message:@kommit.git_message,
                                    revision:@kommit.git_revision,
                                    bare:true)
      branch.destroy_all_post
      branch.create_bare_post_for(@kommit)
      
      redirect_to admin_branch_kommits_path(params[:branch_id])
    end
  
  end
end
