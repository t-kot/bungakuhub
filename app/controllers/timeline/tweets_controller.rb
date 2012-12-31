module Timeline
  class TweetsController < ApplicationController
    before_filter :authenticate_user!

    def index
      @feeds = Tweet.followed_by(current_user)
      render 'timeline/feeds/index'
    end

  end
end
