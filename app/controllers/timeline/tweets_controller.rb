module Timeline
  class TweetsController < ApplicationController
    before_filter :authenticate_user!

    def index
      @tweets = Tweet.followed_by(current_user)
    end

  end
end
