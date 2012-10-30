module Home
  class TextRepositoriesController < ApplicationController
    def index
      @text_repositories = TextRepository.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @text_repositories }
      end
    end
  end
end
