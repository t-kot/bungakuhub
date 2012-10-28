module Home
  class RepositoriesController < ApplicationController
    def index
      @repositories = Repository.all

      respond_to do |format|
        format.html
        format.json { render json: @repositories }
      end
    end
  end
end
