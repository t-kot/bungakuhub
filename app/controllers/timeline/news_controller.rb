module Timeline
  class NewsController < ApplicationController
    before_filter :authenticate_user!

    def index
      @news = News.followed_by(current_user)
    end

  end
end
