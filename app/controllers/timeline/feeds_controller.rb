module Timeline
  class FeedsController < ApplicationController
    before_filter :authenticate_user!

    def index
      @feeds = Feed.followed_by(current_user)
    end

  end
end
