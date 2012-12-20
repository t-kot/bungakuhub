module Admin
  class FilesController < ApplicationController

    def index
      @kommit = Kommit.find(params[:kommit_id])
    end

    def show
      @kommit = Kommit.find(params[:kommit_id])
      @file = @kommit.inspect(params[:name])
    end

  end
end
