module Timeline
  class NewsController < ApplicationController
    before_filter :authenticate_user!

    def index
      @feeds = News.followed_by(current_user)
      render 'timeline/feeds/index'
    end

  end
end
