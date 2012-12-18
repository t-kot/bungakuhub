class FollowingsController < ApplicationController
  before_filter :authenticate_user!, only:[:create]

  def index
  end

  def create
  end

  def destroy
  end

end
