module Admin
  class DiffsController < ApplicationController
    
    def show
      @kommit1 = Kommit.find(params[:kommit_id])
      @kommit2 = Kommit.find(params[:compare_id])
      @repository = @kommit1.repository
      render "/kommits/diff/"
    end

  end
end
